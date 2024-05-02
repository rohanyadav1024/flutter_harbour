import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:harbourhouse/modules/zone/zone_vm.dart';
import 'package:harbourhouse/resources/app_routes.dart';
import 'package:image_picker/image_picker.dart';

import '../../resources/app_colors.dart';
import '../../resources/app_images.dart';
import '../../resources/app_strings.dart';
import '../../utils/common.dart';
import '../../utils/widgets/loader_no_data.dart';
import '../login/login_view/login_view.dart';
import '../venue/venue_view.dart';
import '../venue/venue_vm.dart';

class ZoneView extends StatelessWidget {
  const ZoneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ZoneVM>(builder: (c) {
      return Scaffold(
        //backgroundColor: AppColors.white,
        appBar: MyAppBar(
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              color: AppColors.accentPrimary,
            ),
          ),
          heading: c.venueVM.venue!.name,
        ),
        body: c.isCreating!
            ? SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: MediaQuery.of(getContext()).size.width - 40,
                          margin: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          height: 175,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(c.images.length, (index) {
                                return c.images[index] == null
                                    ? Container(
                                        margin: EdgeInsets.only(right: 15),
                                        width: MediaQuery.of(getContext())
                                                .size
                                                .width -
                                            50,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          onTap: () {
                                            showCupertinoModalPopup(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  CupertinoActionSheet(
                                                      // title: const Text('Choose Options'),
                                                      // message: const Text('Your options are '),
                                                      actions: <Widget>[
                                                    CupertinoActionSheetAction(
                                                      child: Text(
                                                        AppStrings.selectPhoto,
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context,
                                                            AppStrings
                                                                .selectPhoto);
                                                        c.pickImage(ImageSource
                                                            .gallery);
                                                      },
                                                    ),
                                                    CupertinoActionSheetAction(
                                                      child: Text(
                                                        AppStrings.takePhoto,
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context,
                                                            AppStrings
                                                                .takePhoto);
                                                        c.pickImage(
                                                            ImageSource.camera);
                                                      },
                                                    ),
                                                  ],
                                                      cancelButton:
                                                          CupertinoActionSheetAction(
                                                        child: Text(
                                                          AppStrings.cancel,
                                                        ),
                                                        isDefaultAction: true,
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
                                                BorderRadius.circular(16),
                                            child: DottedBorder(
                                                color: AppColors.accentPrimary
                                                    .withOpacity(0.7),
                                                borderType: BorderType.RRect,
                                                strokeWidth: 3,
                                                dashPattern: [6],
                                                radius: Radius.circular(2),
                                                strokeCap: StrokeCap.round,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                  ),
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Icon(
                                                          Icons.add,
                                                          size: 100,
                                                          color: Colors.black54,
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
                                        width: MediaQuery.of(getContext())
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
                                                margin:
                                                    EdgeInsets.only(right: 15),
                                                width:
                                                    MediaQuery.of(getContext())
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
                                                            c.images[index]!
                                                                .image
                                                                .toString(),
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Image.memory(
                                                            base64Decode(c
                                                                .images[index]!
                                                                .image!),
                                                            fit: BoxFit.cover,
                                                          ))),
                                            Positioned(
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Container(
                                                  padding: EdgeInsets.all(3),
                                                  margin: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      color: AppColors
                                                          .accentPrimary,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: InkWell(
                                                    onTap: () {
                                                      c.images.removeAt(index);
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
                        controller: c.zoneNameCtrl,
                        hint: "Enter zone name",
                        labelText: "Zone name",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      AppTextfield(
                        controller: c.descCtrl,
                        hint: "Describe your zone and its features..",
                        labelText: "Description",
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 50, horizontal: 15),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AppTextfield(
                              controller: c.openingTimeCtrl,
                              hint: "Opening time",
                              labelText: "Opening time",
                              readOnly: true,
                              onTap: () {
                                c.selectDate("from", c.openingDate);
                              },
                            ),
                          ),
                          //  SizedBox(width: 10,),
                          Expanded(
                            child: AppTextfield(
                              controller: c.closingTimeCtrl,
                              hint: "Closing time",
                              labelText: "Closing time",
                              readOnly: true,
                              onTap: () {
                                c.selectDate("to", c.closingDate);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      AppTextfield(
                        controller: c.durationCtrl,
                        hint: "Enter duration of each slot",
                        labelText: "Duration in minutes",
                        textInputFormatter: [FilteringTextInputFormatter.digitsOnly],
                        readOnly: c.durationReadOnly,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          "Add Rate",
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
                              controller: c.hrsCtrl,
                              hint: "Enter hour",
                              labelText: "Hour",
                            ),
                          ),
                          //  SizedBox(width: 10,),
                          Expanded(
                            child: AppTextfield(
                              controller: c.rateCtrl,
                              hint: "Enter rate",
                              labelText: "Rates",
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
                                  if (c.rateCtrl.text.trim().isNotEmpty &&
                                      c.hrsCtrl.text.trim().isNotEmpty) {
                                    c.rateJson.add(RatesJson(
                                        hrs: c.hrsCtrl.text.trim(),
                                        rate: c.rateCtrl.text.trim()));
                                    c.rateCtrl.clear();
                                    c.hrsCtrl.clear();
                                    c.update();
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text("Add",
                                      style: TextStyle(color: Colors.black)),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      c.rateJson.isEmpty
                          ? SizedBox(
                              height: 25,
                            )
                          : Container(
                              margin:
                                  EdgeInsets.only(right: 10, left: 10, top: 15),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      topLeft: Radius.circular(8)),
                                  color: AppColors.accentPrimary),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Hours",
                                      style: TextStyle(
                                          color: AppColors.btnPrimary),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Rate",
                                      style: TextStyle(
                                          color: AppColors.btnPrimary),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: null,
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.transparent,
                                    ),
                                  )
                                ],
                              ),
                            ),
                      Container(
                        //height: 200,
                        margin: EdgeInsets.symmetric(horizontal: 0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: List.generate(c.rateJson.length, (index) {
                              return Container(
                                margin: EdgeInsets.only(right: 10, left: 10),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        index == (c.rateJson.length - 1)
                                            ? BorderRadius.only(
                                                bottomLeft: Radius.circular(8),
                                                bottomRight: Radius.circular(8))
                                            : BorderRadius.circular(0),
                                    color: AppColors.accentPrimary),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        c.rateJson[index]!.hrs!,
                                        style: TextStyle(
                                            color: AppColors.btnPrimary),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "₹" + c.rateJson[index]!.rate!,
                                        style: TextStyle(
                                            color: AppColors.btnPrimary),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        c.rateJson.removeAt(index);
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
                        height: 20,
                      ),
                      Row(
                        children: [
                          c.zoneBeingEdited != null
                              ? Container(
                                  margin: EdgeInsets.only(left: 24, right: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.red),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(100),
                                    type: MaterialType.transparency,
                                    child: InkWell(
                                      onTap: () {
                                        showAppDialog(
                                            msg:
                                                "Are you sure you want to delete this zone?",
                                            btnText: "Delete",
                                            onPressed: () async {
                                              var data = {};
                                              data["zone_num"] = c
                                                  .zoneBeingEdited!.zoneNum
                                                  .toString();
                                              data["delete_flag"] = "1";
                                              Get.back();
                                              await c.zoneApi(data: data);
                                            });
                                      },
                                      borderRadius: BorderRadius.circular(100),
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
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
                                  left: c.zoneBeingEdited != null ? 0 : 24,
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
            : ListView(
                children: [
                  Container(
                      width: MediaQuery.of(getContext()).size.width - 50,
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      height: 200,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                              c.venueVM.venue!.venueImg!.length, (index) {
                            return Container(
                                margin: EdgeInsets.only(right: 15),
                                width:
                                    MediaQuery.of(getContext()).size.width - 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16)),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(
                                      c.venueVM.venue!.venueImg![index]
                                          .toString(),
                                      fit: BoxFit.cover,
                                    )));
                          }),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 22, bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          c.venueVM.venue!.name!,
                          style: TextStyle(
                              color: AppColors.accentPrimary,
                              fontWeight: FontWeight.w500,
                              fontSize: 30),
                        )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 22, bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          c.venueVM.venue!.discription!,
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w300,
                              fontSize: 20),
                        ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 22, bottom: 5),
                    child: Row(
                      children: [
                        Icon(
                          Icons.place,
                          color: AppColors.accentPrimary,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Text(
                          c.venueVM.venue!.address!,
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w300,
                              fontSize: 18),
                        ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 22, bottom: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.phone_iphone,
                          color: AppColors.accentPrimary,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Text(
                          c.venueVM.venue!.contNumber!.toString(),
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w300,
                              fontSize: 18),
                        ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 22, bottom: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.local_parking,
                          color: AppColors.accentPrimary,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Text(
                          "Amenities",
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w300,
                              fontSize: 18),
                        ))
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 22, bottom: 10, top: 10),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          "Zones",
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ))
                      ],
                    ),
                  ),
                  c.isLoading!
                      ? const Loader()
                      : c.zones.isEmpty
                          ? const NoData()
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: c.zones.length,
                              itemBuilder: (context, index) {
                                return zoneCard(index, c);
                              },
                            ),
                ],
              ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              c.toggleVenue();
            },
            label: Row(
              children: [
                Icon(
                  c.isCreating! ? Icons.close : Icons.sports_cricket,
                  color: AppColors.btnPrimary,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  c.isCreating! ? "Cancel" : "Add zone",
                  style: TextStyle(color: AppColors.btnPrimary),
                )
              ],
            ),
            backgroundColor: AppColors.accentPrimary),
      );
    });
  }

  Container zoneCard(int index, ZoneVM c) {
    return Container(
      margin: EdgeInsets.only(
        left: 12,
        right: 12,
        top: 6,
        bottom: (index == c.zones.length - 1) ? 80 : 6,
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
            c.selectedZone = c.zones[index];
            getToNamed(AppRoutes.booking);
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
                  child: c.zones[index].zoneImg!.isEmpty
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
                                c.zones[index].zoneImg!.length, (idx) {
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
                                    c.zones[index].zoneImg![
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
                        c.zones[index].name.toString(),
                        style: TextStyle(
                            color: AppColors.accentPrimary,
                            fontSize: 23,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        c.zoneBeingEdited = c.zones[index];
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
                        c.zones[index].discription.toString(),
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
