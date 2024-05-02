import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harbourhouse/main.dart';
import 'package:harbourhouse/modules/dashboard/dashboard_vm.dart';
import 'package:harbourhouse/modules/login/login_view/login_view.dart';
import 'package:harbourhouse/modules/profile/profile_vm.dart';
import 'package:harbourhouse/modules/venue/venue_view.dart';
import 'package:harbourhouse/resources/app_images.dart';
import 'package:harbourhouse/resources/app_routes.dart';
import 'package:harbourhouse/utils/common.dart';
import 'package:harbourhouse/utils/secure_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../resources/app_colors.dart';
import '../../resources/app_strings.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileVM>(builder: (c) {
      return Scaffold(
          appBar: MyAppBar(
            heading: "Profile",
          ),
          backgroundColor: AppColors.white,
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          SizedBox(
                            width: 150,
                            height: 160,
                          ),
                          Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16),
                                  bottomLeft: Radius.circular(0),
                                  topRight: Radius.circular(0),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16),
                                  bottomLeft: Radius.circular(0),
                                  topRight: Radius.circular(0),
                                ),
                                child: 
                                    isValidString(c.existingImg) ?
                                     Image.network(
                                        c.existingImg!,
                                        fit: BoxFit.cover,
                                      ):
                                    c.image != null
                                    ? Image.file(
                                        File(c.image!.path),
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        AppImage.appLogo,
                                        fit: BoxFit.cover,
                                      ),
                              )),
                          Positioned(
                              top: 133,
                              left: 63,
                              child: !c.isEditing!
                                  ? Container()
                                  : Container(
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.5),
                                          color: AppColors.accentPrimary),
                                      child: Material(
                                        type: MaterialType.transparency,
                                        borderRadius:
                                            BorderRadius.circular(12.5),
                                        child: InkWell(
                                          onTap: c.image != null
                                              ? () {
                                                  c.image = null;
                                                  c.image64 = null;
                                                  c.update();
                                                }
                                              : () {
                                                  showCupertinoModalPopup(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        CupertinoActionSheet(
                                                            // title: const Text('Choose Options'),
                                                            // message: const Text('Your options are '),
                                                            actions: <Widget>[
                                                          CupertinoActionSheetAction(
                                                            child: Text(
                                                              AppStrings
                                                                  .selectPhoto,
                                                            ),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context,
                                                                  AppStrings
                                                                      .selectPhoto);
                                                              c.pickImage(
                                                                  ImageSource
                                                                      .gallery);
                                                            },
                                                          ),
                                                          CupertinoActionSheetAction(
                                                            child: Text(
                                                              AppStrings
                                                                  .takePhoto,
                                                            ),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context,
                                                                  AppStrings
                                                                      .takePhoto);
                                                              c.pickImage(
                                                                  ImageSource
                                                                      .camera);
                                                            },
                                                          ),
                                                        ],
                                                            cancelButton:
                                                                CupertinoActionSheetAction(
                                                              child: Text(
                                                                AppStrings
                                                                    .cancel,
                                                              ),
                                                              isDefaultAction:
                                                                  true,
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context,
                                                                    AppStrings
                                                                        .cancel);
                                                              },
                                                            )),
                                                  );
                                                },
                                          borderRadius:
                                              BorderRadius.circular(12.5),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12.5),
                                              ),
                                              child: Center(
                                                  child: c.image != null
                                                      ? Icon(
                                                          Icons.close,
                                                          color: Colors.red,
                                                        )
                                                      : Icon(
                                                          Icons.camera,
                                                          color: AppColors
                                                              .btnPrimary,
                                                        ))),
                                        ),
                                      ),
                                    ))
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.accentPrimary),
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Text(
                          "Role: ${c.role}",
                          style: TextStyle(
                              color: AppColors.btnPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 18),
                            height: 1,
                            color: Colors.grey.shade300,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(right: 24),
                          child: InkWell(
                              onTap: () {
                                c.isEditing = !c.isEditing!;
                                c.image = null;
                                c.image64 = "";
                                if (isValidString(c.contNum)) {
                                  c.mobNoCtrl.text = c.contNum.toString();
                                } else {
                                  c.mobNoCtrl.clear();
                                }
                                if (isValidString(c.name)) {
                                  c.nameCtrl.text = c.name.toString();
                                } else {
                                  c.nameCtrl.clear();
                                }
                                if (isValidString(c.email)) {
                                  c.emailCtrl.text = c.email.toString();
                                } else {
                                  c.emailCtrl.clear();
                                }
                                if (isValidString(c.img)) {
                                  c.existingImg = c.img.toString();
                                } else {
                                  c.existingImg = "";
                                }

                                c.update();
                              },
                              child: Text(
                                c.isEditing! ? "Cancel" : "Edit",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.accentPrimary),
                              )))
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  AppTextfield(
                      controller: c.nameCtrl,
                      hint: "Enter Name",
                      readOnly: c.isEditing! ? false : true),
                  SizedBox(
                    height: 20,
                  ),
                  AppTextfield(
                      controller: c.emailCtrl,
                      hint: "Enter email",
                      readOnly: c.isEditing! ? false : true),
                  SizedBox(
                    height: 20,
                  ),
                  AppTextfield(
                      controller: c.mobNoCtrl,
                      hint: "Enter mobileNum",
                      readOnly: true),
                  SizedBox(
                    height: 30,
                  ),
                  c.isEditing!
                      ? AppPrimaryButton(
                          onPressed: () async {
                            await c.updateProfile();
                          },
                          text: "Save")
                      : Container(),
                  SizedBox(
                    height: 15,
                  ),
                  AppPrimaryButton(
                      onPressed: () async {
                        await SecuredStorage.clearSecureStorage();
                        getOffNamed(AppRoutes.login);
                      },
                      text: "Logout"),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "App version: 1.0.0",
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  )
                ],
              ),
            ),
          ));
    });
  }
}
