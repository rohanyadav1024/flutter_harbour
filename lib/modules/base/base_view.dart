import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harbourhouse/modules/dashboard/dashboard_vm.dart';
import 'package:harbourhouse/resources/app_colors.dart';
import 'package:harbourhouse/resources/app_routes.dart';

import 'base_vm.dart';

class BaseView extends StatelessWidget {
  const BaseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BaseVM>(builder: (c) {
      return Scaffold(
        backgroundColor: AppColors.white,
          body: Navigator(
                                  key: Get.nestedKey(1),
                                  initialRoute: AppRoutes.dashboard,//profileRoute,
                                  onGenerateRoute: c.onGenerateRoute,
                                ),
          bottomNavigationBar: Container(
              height: 75,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {
                        c.changePage(SelectedIndex.dashboard);
                      },
                      icon: c.selectedIndex == SelectedIndex.dashboard
                          ? const Icon(
                              Icons.dashboard,
                              color: AppColors.accentPrimary,
                            )
                          : const Icon(
                              Icons.dashboard_outlined,
                              color: Colors.grey,
                            )),
                  IconButton(
                      onPressed: () {
                        c.changePage(SelectedIndex.venue);
                      },
                      icon: c.selectedIndex == SelectedIndex.venue
                          ? const Icon(
                              Icons.fmd_good_rounded,
                              color: AppColors.accentPrimary,
                            )
                          : const Icon(
                              Icons.fmd_good_outlined,
                              color: Colors.grey,
                            )),
                  IconButton(
                      onPressed: () {
                        c.changePage(SelectedIndex.profile);
                      },
                      icon: c.selectedIndex == SelectedIndex.profile
                          ? const Icon(
                              Icons.person,
                              color: AppColors.accentPrimary,
                            )
                          : const Icon(
                              Icons.person_outline,
                              color: Colors.grey,
                            )),
                ],
              )));
    });
  }
}
