import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:harbourhouse/modules/login/login_model.dart';
import 'package:harbourhouse/modules/login/login_repo/login_repo_impl.dart';
import 'package:harbourhouse/resources/app_routes.dart';
import 'package:harbourhouse/utils/common.dart';
import 'package:harbourhouse/utils/secure_storage.dart';
import 'package:platform_device_id/platform_device_id.dart';

class LoginVM extends GetxController {
  LoginRepoImpl loginRepoImpl = LoginRepoImpl();
  String? mac;
  TextEditingController mobNoCtrl = TextEditingController();
  String? otp;
  bool? isOtpRequired = false;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> init() async {
    await navigate();
    await initPlatformState();
  }

  Future<void> initPlatformState() async {
    String? platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await PlatformDeviceId.getDeviceId;
    } on PlatformException {
      platformVersion = 'Failed to get Device MAC Address.';
    }

    // if(!mounted) return;
    mac = platformVersion;
    debugPrint("MAC FROM DEVICE $mac");
  }

  Future<void> login() async {
    var data = {};
    if (mobNoCtrl.text.trim().isEmpty) {
      showAppDialog(msg: "Mobile number is required");
      return;
    }
    if (mobNoCtrl.text.trim().isNotEmpty && mobNoCtrl.text.trim().length < 10) {
      showAppDialog(msg: "Mobile number is invalid");
      return;
    }
    if (isOtpRequired! && otp == null) {
      showAppDialog(msg: "Otp is required");
      return;
    }

    data["cont_num"] = mobNoCtrl.text.trim();
    data["password"] = mac.toString();
    if (isOtpRequired!) {
      data["otp"] = otp;
    }

    debugPrint("Login data $data");

    await loginRepoImpl.login(data).then((res) async {
      if (res.statusCode == 0) {
        isOtpRequired = false;
        otp = null;
        //store in securestorage
        await storeInSecuredStorage(res);
        getOffNamed(AppRoutes.base);
      } else if (res.statusCode == 1) {
        isOtpRequired = true;
        otp = null;
        getToNamed(AppRoutes.otp);
      } else {
        showAppDialog(msg: res.msg);
      }
    }).onError((error, stackTrace) {
      showAppDialog(msg: error.toString());
    });
  }

  Future<void> storeInSecuredStorage(LoginResponseModel res) async {
    await SecuredStorage.writeStringValue(
        Keys.userId, res.result!.userNum.toString());
    await SecuredStorage.writeStringValue(
        Keys.contNum, res.result!.contNum.toString());
    await SecuredStorage.writeStringValue(
        Keys.firstName, res.result!.name.toString());
    await SecuredStorage.writeStringValue(
        Keys.email, res.result!.email.toString());
    await SecuredStorage.writeStringValue(
        Keys.img, res.result!.img.toString());    
    await SecuredStorage.writeStringValue(
        Keys.role, res.result!.role.toString());
    await SecuredStorage.writeStringValue(
        Keys.walletBal, res.result!.walletBal.toString());
    await SecuredStorage.writeStringValue(
        Keys.token, res.result!.accessToken.toString());
  }

  Future<void> navigate() async {
    String? token = await SecuredStorage.readStringValue(Keys.token);
    if (isValidString(token)) {
      getToNamed(AppRoutes.base);
    }
  }
}
