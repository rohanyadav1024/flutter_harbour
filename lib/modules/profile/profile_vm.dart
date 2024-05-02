import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:harbourhouse/modules/login/login_repo/login_repo_impl.dart';
import 'package:harbourhouse/utils/common.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/secure_storage.dart';
import '../login/login_model.dart';

class ProfileVM extends GetxController {
  LoginRepoImpl loginRepoImpl = LoginRepoImpl();
  String? userId = "", token = "", contNum, name, email, img;
  XFile? image;
  String? image64;
  String? existingImg = "";
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController mobNoCtrl = TextEditingController();
  bool? isLoading = true;

  bool? isEditing = false;

  String? role;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> init() async {
    userId = await SecuredStorage.readStringValue(Keys.userId);
    token = await SecuredStorage.readStringValue(Keys.token);
    contNum = await SecuredStorage.readStringValue(Keys.contNum);
    role = await SecuredStorage.readStringValue(Keys.role);
    name = await SecuredStorage.readStringValue(Keys.firstName);
    email = await SecuredStorage.readStringValue(Keys.email);
    img = await SecuredStorage.readStringValue(Keys.img);

    if (isValidString(contNum)) {
      mobNoCtrl.text = contNum.toString();
    }
    if (isValidString(name)) {
      nameCtrl.text = name.toString();
    }
    if (isValidString(email)) {
      emailCtrl.text = email.toString();
    }
    if (isValidString(img)) {
      existingImg = img.toString();
    }
    if (isValidString(role)) {
      if (role.toString() == "U") {
        role = "User";
      } else if (role.toString() == "A") {
        role = "Admin";
      }
    }
    isLoading = false;
    update();
  }

  Future<void> pickImage(ImageSource imageSource) async {
    ImagePicker picker = ImagePicker();
    image = await picker.pickImage(source: imageSource);
    if (image != null) {
      final bytes = File(image!.path).readAsBytesSync();
      image64 = base64Encode(bytes);
    }
    update();
  }

  Future<void> updateProfile() async {
    var data = {};
    if (nameCtrl.text.trim().isNotEmpty) {
      data["name"] = nameCtrl.text.trim();
    }
    if (emailCtrl.text.trim().isNotEmpty) {
      data["email"] = emailCtrl.text.trim();
    }
    if (image64!.trim().isNotEmpty) {
      data["img"] = image64!.trim();
    }

    await loginRepoImpl.login(data).then((res) async {
      if (res.statusCode == 0) {
        await storeInSecuredStorage(res);
        isEditing = false;
      } else {
        showAppDialog(msg: res.msg);
      }
      update();
    }).onError((error, stackTrace) {
      update();
      showAppDialog(msg: error.toString());
    });
  }

  Future<void> storeInSecuredStorage(LoginResponseModel res) async {
    await SecuredStorage.writeStringValue(
        Keys.userId, res.result!.userNum.toString());
    await SecuredStorage.writeStringValue(
        Keys.contNum, res.result!.contNum.toString());
    contNum = res.result!.contNum.toString();
    await SecuredStorage.writeStringValue(
        Keys.firstName, res.result!.name.toString());
    name = res.result!.name.toString();
    await SecuredStorage.writeStringValue(
        Keys.email, res.result!.email.toString());
    email = res.result!.email.toString();
    await SecuredStorage.writeStringValue(Keys.img, res.result!.img.toString());
    existingImg = res.result!.img.toString();
    await SecuredStorage.writeStringValue(
        Keys.role, res.result!.role.toString());
    await SecuredStorage.writeStringValue(
        Keys.walletBal, res.result!.walletBal.toString());
    await SecuredStorage.writeStringValue(
        Keys.token, res.result!.accessToken.toString());
  }
}
