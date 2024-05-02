import 'package:get/get_state_manager/get_state_manager.dart';

import '../../utils/common.dart';
import '../../utils/secure_storage.dart';

class DashboardVM extends GetxController {
  String? userId = "", token = "", contNum = "N/A";
  String? name;

  bool? isLoading = true;

  String? role;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> init() async {
    userId = await SecuredStorage.readStringValue(Keys.userId);
    token = await SecuredStorage.readStringValue(Keys.token);
    var contNum = await SecuredStorage.readStringValue(Keys.contNum);
    role = await SecuredStorage.readStringValue(Keys.role);
    var name = await SecuredStorage.readStringValue(Keys.firstName);
    if (isValidString(name)) {
      this.contNum = name.toString();
    }else if 
     (isValidString(contNum)) {
      this.contNum = contNum.toString();
    }
    if (isValidString(role)) {
      if (role.toString() == "U") {
        role = "User";
      } else if (role.toString() == "U") {
        role = "Admin";
      }
    }
    isLoading = false;
    update();
  }
}
