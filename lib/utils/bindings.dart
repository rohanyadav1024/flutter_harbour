import 'package:get/get.dart';
import 'package:harbourhouse/modules/booking/booking_vm.dart';
import 'package:harbourhouse/modules/venue/venue_vm.dart';
import 'package:harbourhouse/modules/zone/zone_vm.dart';

import '../modules/base/base_vm.dart';
import '../modules/dashboard/dashboard_vm.dart';
import '../modules/login/login_vm.dart';
import '../modules/profile/profile_vm.dart';
import '../modules/txns/txns_vm.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginVM());
  }
}

class BaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BaseVM());
  }
}

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardVM());
  }
}

class VenueBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(VenueVM());
  }
}

class ZoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ZoneVM());
  }
}

class BookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BookingVM());
  }
}

class TxnsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TxnsVM());
  }
}

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProfileVM());
  }
}