import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:harbourhouse/modules/login/login_view/login_view.dart';
import 'package:harbourhouse/modules/venue/venue_vm.dart';
import 'package:harbourhouse/resources/app_colors.dart';
import 'package:harbourhouse/resources/app_routes.dart';
import 'package:harbourhouse/utils/common.dart';
import 'package:image_picker/image_picker.dart';

import '../../resources/app_images.dart';
import '../../resources/app_strings.dart';
import '../../utils/widgets/loader_no_data.dart';

class VenueView extends StatelessWidget {
  const VenueView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VenueVM>(builder: (c) {
      return Scaffold(
        //backgroundColor: AppColors.white,
        appBar: MyAppBar(
          heading: "Venues",
        ),
        body: c.isLoading!
            ? const Loader()
            : c.venues.isEmpty
                ? const NoData()
                : c.isCreating!
                    ? SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width:
                                      MediaQuery.of(getContext()).size.width -
                                          40,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  height: 175,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: List.generate(c.images.length,
                                          (index) {
                                        return c.images[index] == null
                                            ? Container(
                                                margin:
                                                    EdgeInsets.only(right: 15),
                                                width:
                                                    MediaQuery.of(getContext())
                                                            .size
                                                            .width -
                                                        50,
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  onTap: () {
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
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    child: DottedBorder(
                                                        color: AppColors
                                                            .accentPrimary
                                                            .withOpacity(0.7),
                                                        borderType:
                                                            BorderType.RRect,
                                                        strokeWidth: 3,
                                                        dashPattern: [6],
                                                        radius:
                                                            Radius.circular(2),
                                                        strokeCap:
                                                            StrokeCap.round,
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                          ),
                                                          child: Center(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Icon(
                                                                  Icons.add,
                                                                  size: 100,
                                                                  color: Colors
                                                                      .black54,
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Text(
                                                                  "Add Image",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        )),
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                width:
                                                    MediaQuery.of(getContext())
                                                            .size
                                                            .width -
                                                        75,
                                                child: Stack(
                                                  children: [
                                                    // SizedBox(width: MediaQuery.of(
                                                    //                 getContext())
                                                    //             .size
                                                    //             .width -
                                                    //         75,
                                                    //         height: 175,
                                                    //         ),
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            right: 15),
                                                        width: MediaQuery.of(
                                                                    getContext())
                                                                .size
                                                                .width -
                                                            75,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    16)),
                                                        child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    16),
                                                            child: c.images[index]!
                                                                        .type ==
                                                                    ImageFormat.network
                                                                ? Image.network(
                                                                    c
                                                                        .images[
                                                                            index]!
                                                                        .image
                                                                        .toString(),
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  )
                                                                : Image.memory(
                                                                    base64Decode(c
                                                                        .images[
                                                                            index]!
                                                                        .image!),
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ))),
                                                    Positioned(
                                                      child: Align(
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(3),
                                                          margin:
                                                              EdgeInsets.all(
                                                                  10),
                                                          decoration: BoxDecoration(
                                                              color: AppColors
                                                                  .accentPrimary,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12)),
                                                          child: InkWell(
                                                            onTap: () {
                                                              c.images.removeAt(
                                                                  index);
                                                              c.update();
                                                            },
                                                            child: Icon(
                                                              Icons.close,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                      }),
                                    ),
                                  )),
                              AppTextfield(
                                controller: c.venueNameCtrl,
                                hint: "Enter venue name",
                                labelText: "Venue name",
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              AppTextfield(
                                controller: c.descCtrl,
                                hint: "Describe you venue and its features..",
                                labelText: "Description",
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 50, horizontal: 15),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              AppTextfield(
                                controller: c.addresCtrl,
                                hint: "Enter address",
                                labelText: "Address",
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              AppTextfield(
                                controller: c.contNumCtrl,
                                textInputFormatter: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                maxLen: 10,
                                maxLines: 1,
                                hint: "Enter contact number",
                                labelText: "Contact Number",
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: Text(
                                  "Add Amenities",
                                  style: TextStyle(
                                      color: AppColors.accentPrimary,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: AppTextfield(
                                      controller: c.amenityCtrl,
                                      hint: "Enter amenity name",
                                      labelText: "Amenity",
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
                                    margin: EdgeInsets.only(right: 24),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.grey.shade200),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(4),
                                      type: MaterialType.transparency,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(4),
                                        onTap: () {
                                          if (c.amenityCtrl.text
                                              .trim()
                                              .isNotEmpty) {
                                            c.amenities
                                                .add(c.amenityCtrl.text.trim());
                                            c.amenityCtrl.clear();
                                            c.update();
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Text("Add",
                                              style: TextStyle(
                                                  color: Colors.black)),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                height: 50,
                                margin: EdgeInsets.symmetric(horizontal: 24),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: List.generate(c.amenities.length,
                                        (index) {
                                      return Container(
                                        margin: EdgeInsets.only(right: 10),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: AppColors.accentPrimary),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              c.amenities[index]!,
                                              style: TextStyle(
                                                  color: AppColors.btnPrimary),
                                            ),
                                            SizedBox(
                                              width: 7,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                c.amenities.removeAt(index);
                                                c.update();
                                              },
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.redAccent,
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 0,
                              ),
                              Row(
                                children: [
                                  c.venueBeingEdited != null
                                      ? Container(
                                          margin: EdgeInsets.only(
                                              left: 24, right: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: Colors.red),
                                          child: Material(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            type: MaterialType.transparency,
                                            child: InkWell(
                                              onTap: () {
                                                showAppDialog(
                                                    msg:
                                                        "Are you sure you want to delete this venue?",
                                                    btnText: "Delete",
                                                    onPressed: () async {
                                                      var data = {};
                                                      data["venue_num"] = c
                                                          .venueBeingEdited!
                                                          .venueNum
                                                          .toString();
                                                      data["delete_flag"] = "1";
                                                      Get.back();
                                                      await c.venueApi(
                                                          data: data);
                                                    });
                                              },
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                                  child: Center(
                                                      child: Icon(
                                                    Icons.delete_outline,
                                                    color: AppColors.white,
                                                  ))),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  Expanded(
                                    child: AppPrimaryButton(
                                      onPressed: () {
                                        c.validateData();
                                      },
                                      text: "Submit",
                                      margin: EdgeInsets.only(
                                          left: c.venueBeingEdited != null
                                              ? 0
                                              : 24,
                                          right: 150),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 14, horizontal: 10),
                                      radiusBL: 100,
                                      radiusBR: 100,
                                      radiusTL: 100,
                                      radiusTR: 100,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 3,
                              ),
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: c.venues.length,
                        itemBuilder: (context, index) {
                          return venueCard(index, c);
                        },
                      ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              c.toggleVenue();
            },
            label: Row(
              children: [
                Icon(
                  c.isCreating! ? Icons.close : Icons.fmd_good_rounded,
                  color: AppColors.btnPrimary,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  c.isCreating! ? "Cancel" : "Add Venue",
                  style: TextStyle(color: AppColors.btnPrimary),
                )
              ],
            ),
            backgroundColor: AppColors.accentPrimary),
      );
    });
  }

  Container venueCard(int index, VenueVM c) {
    return Container(
      margin: EdgeInsets.only(
        left: 12,
        right: 12,
        top: 6,
        bottom: (index == c.venues.length - 1) ? 80 : 6,
      ),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: CupertinoColors.lightBackgroundGray,
                offset: Offset(1, 1),
                blurRadius: 5,
                spreadRadius: 1)
          ]),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            c.venue = c.venues[index];
            getToNamed(AppRoutes.zone);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 160,
                  width: double.infinity,
                  child: c.venues[index].venueImg!.isEmpty
                      ? Container(
                          height: 160,
                          margin: EdgeInsets.only(right: 5),
                          width: MediaQuery.of(getContext()).size.width - 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              AppImage
                                  .appLogo, //"https://picsum.photos/200/300",
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                                c.venues[index].venueImg!.length, (idx) {
                              return Container(
                                height: 160,
                                margin: EdgeInsets.only(right: 5),
                                width:
                                    MediaQuery.of(getContext()).size.width - 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    c.venues[index].venueImg![
                                        idx], //"https://picsum.photos/200/300",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        c.venues[index].name.toString(),
                        style: TextStyle(
                            color: AppColors.accentPrimary,
                            fontSize: 23,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        c.venueBeingEdited = c.venues[index];
                        c.setVenueData();
                      },
                      child: Icon(
                        Icons.edit,
                        size: 25,
                        color: AppColors.btnPrimary,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        c.venues[index].discription.toString(),
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    this.height,
    this.margin,
    this.padding,
    this.leading,
    this.leadingPressed,
    this.actions,
    this.heading,
    Key? key,
  }) : super(key: key);

  final double? height;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Widget? leading;
  final VoidCallback? leadingPressed;
  final List<Widget>? actions;
  final String? heading;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: Size(double.infinity, height ?? 65),
        child: Container(
          height: height ?? 65,
          // color: Colors.grey,
          margin: margin ?? const EdgeInsets.only(top: 35),
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              leading ?? Container(),
              leading == null
                  ? Container()
                  : const SizedBox(
                      width: 20,
                    ),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          heading ?? AppStrings.appName,
                          style: TextStyle(
                              color: AppColors.accentPrimary,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: actions ?? [Container()],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  @override
  Size get preferredSize => Size(double.infinity, height ?? 65);
}
