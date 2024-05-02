import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:harbourhouse/modules/login/login_view/login_view.dart';
import 'package:harbourhouse/modules/login/login_vm.dart';
import 'package:harbourhouse/resources/app_colors.dart';
import 'package:harbourhouse/resources/app_strings.dart';

class OtpView extends StatelessWidget {
  const OtpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginVM>(builder: (c) {
      return Scaffold(
          body: ListView(
        children: [
          Container(
            height: 125,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
            color: Colors.grey.shade200,
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.arrow_back_outlined,
                      color: Colors.grey,
                    ),
                  ),
                  const Text(
                    AppStrings.verifyOtp,
                    style: TextStyle(
                        color: AppColors.accentPrimary,
                        fontWeight: FontWeight.w500,
                        fontSize: 25),
                  )
                ]),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "${AppStrings.otpSentText}${c.mobNoCtrl.text.trim()}",
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          OtpTextField(
            autoFocus: true,
            borderColor: AppColors.accentPrimary,
            focusedBorderColor: AppColors.accentPrimary,
            onSubmit: (t) {
              c.otp = t;
              c.login();
            },
          ),
          const SizedBox(
            height: 40,
          ),
          AppPrimaryButton(
              onPressed: () {
                c.login();
              },
              text: AppStrings.verifyNcontinue),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {},
                  child: const Text(
                    AppStrings.resendOtp,
                    style: TextStyle(
                        color: AppColors.accentPrimary,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          )
        ],
      ));
    });
  }
}
