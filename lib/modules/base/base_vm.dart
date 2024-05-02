import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harbourhouse/modules/dashboard/dashboard_view.dart';
import 'package:harbourhouse/modules/venue/venue_view.dart';
import 'package:harbourhouse/resources/app_routes.dart';
import 'package:harbourhouse/utils/bindings.dart';

import '../profile/profile_view.dart';

class BaseVM extends GetxController {
  int selectedIndex = SelectedIndex.dashboard;

  List<String> pages = [
    AppRoutes.dashboard,
    AppRoutes.venue,
    AppRoutes.profile
  ];

  void changePage(int index) {
    selectedIndex = index;
    update();
    Get.toNamed(
      pages[index],
      id: 1,
    );
  }

  Route? onGenerateRoute(RouteSettings settings) {
    // Get.deleteAll(force: true);
    if (settings.name == AppRoutes.dashboard) {
      return GetPageRoute(
        settings: settings,
        page: () => const DashboardView(),
        binding: DashboardBinding(),
      );
    }

    if (settings.name == AppRoutes.venue) {
      return GetPageRoute(
        settings: settings,
        page: () => const VenueView(),
        binding: VenueBinding(),
      );
    }

    if (settings.name == AppRoutes.profile) {
      return GetPageRoute(
        settings: settings,
        page: () => const ProfileView(),
        binding: ProfileBinding(),
      );
    }

    return null;
  }
}

class SelectedIndex {
  static const dashboard = 0;
  static const venue = 1;
  static const profile = 2;
}
