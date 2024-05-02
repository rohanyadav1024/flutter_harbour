import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:harbourhouse/modules/login/login_vm.dart';
import 'package:harbourhouse/resources/app_colors.dart';
import 'package:harbourhouse/resources/app_images.dart';
import 'package:harbourhouse/resources/app_routes.dart';
import 'package:harbourhouse/resources/app_strings.dart';
import 'package:harbourhouse/utils/common.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginVM>(builder: (c) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          child: Column(
            //shrinkWrap: true,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2.35,
                width: double.infinity,
                child: Image.asset(
                  AppImage.appLogo,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 25),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Expanded(
                      child: Text(
                    AppStrings.appName,
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -2),
                    textAlign: TextAlign.center,
                  ))
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              const Center(
                child: Text(
                  AppStrings.login,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 45,
              ),
              AppTextfield(
                controller: c.mobNoCtrl,
                hint: AppStrings.enterMobNo,
                autoFocus: true,
                icon: Icon(
                  Icons.phone_iphone,
                  color: AppColors.accentPrimary.withOpacity(0.7),
                ),
                textInputFormatter: [FilteringTextInputFormatter.digitsOnly],
                maxLen: 10,
                maxLines: 1,
              ),
              const SizedBox(
                height: 15,
              ),
              AppPrimaryButton(
                onPressed: () {
                  c.login();
                },
                text: AppStrings.continuee,
                icon: const Icon(
                  Icons.arrow_right_alt_outlined,
                  color: AppColors.btnPrimary,
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}

class AppTextfield extends StatelessWidget {
  const AppTextfield({
    required this.controller,
    required this.hint,
    this.icon,
    this.margin,
    this.radiusTL,
    this.radiusTR,
    this.radiusBR,
    this.radiusBL,
    this.onChanged,
    this.autoFocus = false,
    this.maxLen,
    this.maxLines,
    this.textInputFormatter,
    this.labelText,
    this.contentPadding,
    this.readOnly = false,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final String hint;
  final Widget? icon;
  final EdgeInsets? margin;
  final double? radiusTL, radiusTR, radiusBR, radiusBL;
  final Function(String)? onChanged;
  final bool? autoFocus;
  final int? maxLen, maxLines;
  final List<TextInputFormatter>? textInputFormatter;
  final String? labelText;
  final EdgeInsets? contentPadding;
  final bool? readOnly;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: TextField(
          controller: controller,
          onChanged: onChanged ?? (t) {},
          autofocus: autoFocus!,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: const BorderSide(
                      width: 2, color: AppColors.accentPrimary),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radiusTL ?? 10),
                    bottomRight: Radius.circular(radiusBR ?? 10),
                    topRight: Radius.circular(radiusTR ?? 0),
                    bottomLeft: Radius.circular(radiusBL ?? 0),
                  )),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      width: 2, color: AppColors.accentPrimary),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radiusTL ?? 10),
                    bottomRight: Radius.circular(radiusBR ?? 10),
                    topRight: Radius.circular(radiusTR ?? 0),
                    bottomLeft: Radius.circular(radiusBL ?? 0),
                  )),
              contentPadding: contentPadding,
              hintText: hint,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              filled: true,
              fillColor: AppColors.btnPrimary.withOpacity(0.1),
              label: Text(
                labelText ?? hint,
                style: const TextStyle(
                    color: AppColors.accentPrimary,
                    fontWeight: FontWeight.w500),
              ),
              prefixIcon: icon,
              hintStyle: const TextStyle(fontSize: 20)),
          maxLength: maxLen,
          textAlignVertical: TextAlignVertical.top,
          textAlign: TextAlign.start,
          maxLines: maxLines,
          readOnly: readOnly!,
          inputFormatters: textInputFormatter,
          onTap: onTap,
          style: const TextStyle(fontSize: 20)),
    );
  }
}

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    required this.onPressed,
    required this.text,
    this.margin,
    this.padding,
    this.radiusTL,
    this.radiusTR,
    this.radiusBL,
    this.radiusBR,
    this.icon,
    this.childrenAlignment,
    Key? key,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String? text;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? radiusTL, radiusTR, radiusBL, radiusBR;
  final Widget? icon;
  final MainAxisAlignment? childrenAlignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
          color: AppColors.accentPrimary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radiusTL ?? 10),
            bottomRight: Radius.circular(radiusBR ?? 10),
            topRight: Radius.circular(radiusTR ?? 0),
            bottomLeft: Radius.circular(radiusBL ?? 0),
          ),
          boxShadow: const [
            BoxShadow(
                color: Colors.grey,
                offset: Offset(1, 1),
                blurRadius: 20,
                spreadRadius: -10)
          ]),
      child: Material(
        type: MaterialType.transparency,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radiusTL ?? 10),
          bottomRight: Radius.circular(radiusBR ?? 10),
          topRight: Radius.circular(radiusTR ?? 0),
          bottomLeft: Radius.circular(radiusBL ?? 0),
        ),
        child: InkWell(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radiusTL ?? 10),
            bottomRight: Radius.circular(radiusBR ?? 10),
            topRight: Radius.circular(radiusTR ?? 0),
            bottomLeft: Radius.circular(radiusBL ?? 0),
          ),
          onTap: onPressed ?? () {},
          child: Container(
            padding: padding ??
                const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusTL ?? 10),
                bottomRight: Radius.circular(radiusBR ?? 10),
                topRight: Radius.circular(radiusTR ?? 0),
                bottomLeft: Radius.circular(radiusBL ?? 0),
              ),
            ),
            child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: childrenAlignment ??
                    (icon == null
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.spaceBetween),
                children: [
                  Text(
                    text!,
                    style: const TextStyle(
                        color: AppColors.btnPrimary,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  icon ?? Container()
                ]),
          ),
        ),
      ),
    );
  }
}
