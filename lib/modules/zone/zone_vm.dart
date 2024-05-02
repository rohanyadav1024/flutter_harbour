import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harbourhouse/modules/zone/zone_model.dart';
import 'package:harbourhouse/modules/zone/zone_repo/zone_repo_impl.dart';
import 'package:harbourhouse/resources/app_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../utils/common.dart';
import '../../utils/secure_storage.dart';
import '../venue/venue_vm.dart';

class ZoneVM extends GetxController {
  VenueVM venueVM = Get.find<VenueVM>();
  ZoneRepoImpl zoneRepoImp = ZoneRepoImpl();
  bool? isLoading = true;
  String? userId = "", token = "";
  List<Datum> zones = List.empty(growable: true);
  bool? isCreating = false;
  List<RatesJson?> rateJson = List.empty(growable: true);
  TextEditingController rateCtrl = TextEditingController();
  TextEditingController zoneNameCtrl = TextEditingController();
  TextEditingController descCtrl = TextEditingController();
  TextEditingController hrsCtrl = TextEditingController();
  TextEditingController openingTimeCtrl = TextEditingController();
  TextEditingController closingTimeCtrl = TextEditingController();
  TextEditingController durationCtrl = TextEditingController();
  XFile? image;
  List<ImageType?> images = List.empty(growable: true);
  DateTime? openingDate, closingDate;
  String? openingDateStr, closingDateStr;

  Datum? zoneBeingEdited;
  Datum? selectedZone;
  
  bool durationReadOnly = false;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> init() async {
    userId = await SecuredStorage.readStringValue(Keys.userId);
    token = await SecuredStorage.readStringValue(Keys.token);
    images.clear();
    images.add(null);
    await getZones();
    isLoading = false;
    update();
  }

  void setVenueData() {
    if (zoneBeingEdited != null) {
      images.clear();
      for (var i = 0; i < zoneBeingEdited!.zoneImg!.length; i++) {
        images
            .add(ImageType(zoneBeingEdited!.zoneImg![i], ImageFormat.network));
      }
      images.add(null);

      zoneNameCtrl.text = zoneBeingEdited!.name.toString();
      descCtrl.text = zoneBeingEdited!.discription.toString();

      openingDate = timeFormatFromApi(zoneBeingEdited!.openTime.toString());
      openingDateStr = timeFormatHHmm(openingDate);
      openingTimeCtrl.text = openingDateStr!;

      closingDate = timeFormatFromApi(zoneBeingEdited!.closeTime.toString());
      closingDateStr = timeFormatHHmm(closingDate);
      closingTimeCtrl.text = closingDateStr!;

      durationCtrl.text = zoneBeingEdited!.slot!.toString();
      durationReadOnly = true;
      // addresCtrl.text = zoneBeingEdited!.address.toString();
      // contNumCtrl.text = zoneBeingEdited!.contNumber.toString();

      rateJson.clear();
      try {
        var rj = jsonDecode(zoneBeingEdited!.rateJson.toString()) as List;
        for (var i = 0; i < rj.length; i++) {
          rateJson.add(RatesJson(
              hrs: rj[i]["hour"].toString(), rate: rj[i]["rate"].toString()));
        }
      } catch (e) {
        showAppDialog(msg: "Invalid data for Rate Json");
      }
      isCreating = true;
      update();
    }
  }

  Future<void> getZones() async {
    Map data = {};
    isLoading = true;
    update();
    zones.clear();
    data["venue_num"] = venueVM.venue!.venueNum.toString();
    debugPrint("ZData List $data");
    await zoneRepoImp.getZones(data).then((response) {
      if (response.statusCode == 0) {
        zones.addAll(response.data!);
      } else {
        showAppDialog(msg: response.msg);
      }
      isLoading = false;
      update();
    }).onError((error, stackTrace) {
      showAppDialog(msg: error.toString());
      isLoading = false;
      update();
    });
  }

  Future<void> zoneApi({Map? data}) async {
    debugPrint("ZData $data");
    await zoneRepoImp.zoneApi(data!).then((response) {
      if (response.statusCode == 0) {
        getZones();
      } else {
        showAppDialog(msg: response.msg);
      }
      clearForm();
    }).onError((error, stackTrace) {
      showAppDialog(msg: error.toString());
      clearForm();
    });
  }

  void validateData() async {
    if (zoneNameCtrl.text.trim().isEmpty) {
      showAppDialog(msg: "Turf name is required");
      return;
    }
    if (openingTimeCtrl.text.trim().isEmpty) {
      showAppDialog(msg: "Opening time is required");
      return;
    }
    if (closingTimeCtrl.text.trim().isEmpty) {
      showAppDialog(msg: "Closing time is required");
      return;
    }
    if (durationCtrl.text.trim().isEmpty) {
      showAppDialog(msg: "Duration is required");
      return;
    }
    if (rateJson.isEmpty) {
      showAppDialog(msg: "Rates are required");
      return;
    }
    // if (contNumCtrl.text.trim().isEmpty) {
    //   showAppDialog(msg: "Contact number is required");
    //   return;
    // }

    var data = {};
    if (zoneBeingEdited != null) {
      data["zone_num"] = zoneBeingEdited!.zoneNum.toString();
    }
    data["venue_num"] = venueVM.venue!.venueNum.toString();
    data["name"] = zoneNameCtrl.text.trim();
    data["open_time"] = timeFormatToApi(openingDate!);
    data["close_time"] = timeFormatToApi(closingDate!);
    data["slot"] = durationCtrl.text.toString();
    //data["cont_number"] = contNumCtrl.text.trim();
    //data["address"] = addresCtrl.text.trim();

    if (descCtrl.text.trim().isNotEmpty) {
      data["discription"] = descCtrl.text.trim();
    }
    if (rateJson.isNotEmpty) {
      var rj = [];
      for (var i = 0; i < rateJson.length; i++) {
        var obj = {};
        obj["hour"] = rateJson[i]!.hrs.toString();
        obj["rate"] = rateJson[i]!.rate.toString();
        rj.add(obj);
      }
      data["rate_json"] = jsonEncode(rj);
    }

    if (images.isNotEmpty && images.length > 1) {
      var imgs = [];
      for (var i = 0; i < images.length - 1; i++) {
        imgs.add(images[i]!.image);
      }
      data["zone_img"] = jsonEncode(imgs);
    }

    await zoneApi(data: data);
    clearForm();
  }

  void clearForm() {
    zoneNameCtrl.clear();
    descCtrl.clear();
    //addresCtrl.clear();
    //contNumCtrl.clear();
    rateJson.clear();
    images.clear();
    images.add(null);
    zoneBeingEdited = null;
    isCreating = false;
    update();
  }

  void toggleVenue() {
    isCreating = !isCreating!;
    if (isCreating!) {
      clearForm();
      isCreating = true;
    }
    update();
  }

  Future<void> pickImage(ImageSource imageSource) async {
    ImagePicker picker = ImagePicker();
    image = await picker.pickImage(source: imageSource);
    if (image != null) {
      final bytes = File(image!.path).readAsBytesSync();
      String img64 = base64Encode(bytes);
      images.insert(images.length - 1, ImageType(img64, ImageFormat.memory));
    }
    update();
  }

  Future<void> selectDate(type, DateTime? date) async {
    final TimeOfDay? picked = await showTimePicker(
      context: getContext(),
      initialTime: date == null
          ? TimeOfDay.now()
          : TimeOfDay(hour: date.hour, minute: date.minute),
      // firstDate: DateTime(1800),
      //lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.accentPrimary, // <-- SEE HERE
              // onPrimary: Colors.redAccent, // <-- SEE HERE
              onSurface: AppColors.accentPrimary, // <-- SEE HERE
            ),
            textButtonTheme:
                //kIsWeb
                //?
                TextButtonThemeData(
              style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color>(AppColors.accentPrimary),
              ),
            ),
            //:TextButtonThemeData(
            // style: TextButton.styleFrom(
            //foregroundColor:
            //   AppColors.kPrimaryDarkColor, // button text color
            //),
            //),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      DateTime? pickedInDate = DateTime(2000, 1, 1, picked.hour, picked.minute);
      update();
      if (pickedInDate != null && type == "from") {
        if (closingDate != null && pickedInDate.isAfter(closingDate!)) {
          Get.snackbar("Invalid time selection",
              "'To' time cannot be greater than 'From' time",
              backgroundColor: AppColors.accentPrimary,
              colorText: Colors.white,
              duration: Duration(seconds: 4),
              snackPosition: SnackPosition.BOTTOM);
          return;
        }
        openingDate = DateTime(2000, 1, 1, picked.hour, picked.minute);
        openingDateStr = timeFormatHHmm(openingDate!);
        openingTimeCtrl.text = openingDateStr!;
      } else if (pickedInDate != null && type == "to") {
        if (openingDate != null && pickedInDate.isBefore(openingDate!)) {
          Get.snackbar("Invalid Time selection",
              "'From' time cannot be smaller than 'To' time",
              backgroundColor: AppColors.accentPrimary,
              colorText: Colors.white,
              duration: Duration(seconds: 4),
              snackPosition: SnackPosition.BOTTOM);
          return;
        }
        closingDate = pickedInDate;
        closingDateStr = timeFormatHHmm(closingDate!);
        closingTimeCtrl.text = closingDateStr!;
      }
      update();
    }
  }

  String timeFormatToApi(DateTime? date) {
    return DateFormat("yyyy-MM-dd HH:mm").format(date!);
  }

  String? timeFormatHHmm(DateTime? date) {
    return DateFormat("HH:mm a").format(date!);
  }

  DateTime? timeFormatFromApi(String? date) {
    return DateFormat("yyyy-MM-dd HH:mm").parse(date!);
  }
}

class RatesJson {
  RatesJson({this.hrs, this.rate});

  String? hrs;
  String? rate;
}
