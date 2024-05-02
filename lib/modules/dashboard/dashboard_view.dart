import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harbourhouse/modules/dashboard/dashboard_vm.dart';

import '../../resources/app_colors.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardVM>(
      builder: (c) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: ListView(
            children: [
              SizedBox(height: 45,),
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Text("Hello!", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 35),),
              ),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Text(c.contNum.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/2.7,),
              Container(
              child: Center(child: Text("Dashboard")),
        ),
            ],
          ));
      }
    );
  }
}