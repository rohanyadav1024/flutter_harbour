import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:harbourhouse/modules/venue/venue_repo/venue_repo_impl.dart';
import 'package:harbourhouse/modules/venue/venues_model.dart';
import 'package:harbourhouse/utils/common.dart';
import 'package:harbourhouse/utils/secure_storage.dart';
import 'package:image_picker/image_picker.dart';

class VenueVM extends GetxController {
  VenueRepoImp venueRepoImp = VenueRepoImp();
  bool? isLoading = true;
  String? userId = "", token = "";
  List<Datum> venues = List.empty(growable: true);
  bool? isCreating = false;
  List<String?> amenities = List.empty(growable: true);
  TextEditingController amenityCtrl = TextEditingController();
  TextEditingController venueNameCtrl = TextEditingController();
  TextEditingController descCtrl = TextEditingController();
  TextEditingController addresCtrl = TextEditingController();
  TextEditingController contNumCtrl = TextEditingController();
  Datum? venue;
  Datum? venueBeingEdited;

  XFile? image;
  List<ImageType?> images = List.empty(growable: true);

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
    await getVenues();
    isLoading = false;
    update();
  }

  void setVenueData() {
    if (venueBeingEdited != null) {
      images.clear();
      for (var i = 0; i < venueBeingEdited!.venueImg!.length; i++) {
        images.add(
            ImageType(venueBeingEdited!.venueImg![i], ImageFormat.network));
      }
      images.add(null);

      venueNameCtrl.text = venueBeingEdited!.name.toString();
      descCtrl.text = venueBeingEdited!.discription.toString();
      addresCtrl.text = venueBeingEdited!.address.toString();
      contNumCtrl.text = venueBeingEdited!.contNumber.toString();

      amenities.clear();
      try {
        var amn = jsonDecode(venueBeingEdited!.amenties.toString()) as List;
        for (var i = 0; i < amn.length; i++) {
          amenities.add(amn[i]);
        }
      } catch (e) {
        showAppDialog(msg: "Invalid data for amenities");
      }
      isCreating = true;
      update();
    }
  }

  Future<void> getVenues() async {
    //Map data = {};
    isLoading = true;
    update();
    venues.clear();
    await venueRepoImp.getVenues({}).then((response) {
      if (response.statusCode == 0) {
        venues.addAll(response.data!);
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

  void validateData() async {
    if (venueNameCtrl.text.trim().isEmpty) {
      showAppDialog(msg: "Venue name is required");
      return;
    }
    if (addresCtrl.text.trim().isEmpty) {
      showAppDialog(msg: "Address is required");
      return;
    }
    if (contNumCtrl.text.trim().isEmpty) {
      showAppDialog(msg: "Contact number is required");
      return;
    }

    var data = {};
    if (venueBeingEdited != null) {
      data["venue_num"] = venueBeingEdited!.venueNum.toString();
    }
    data["name"] = venueNameCtrl.text.trim();
    data["cont_number"] = contNumCtrl.text.trim();
    data["address"] = addresCtrl.text.trim();

    if (descCtrl.text.trim().isNotEmpty) {
      data["discription"] = descCtrl.text.trim();
    }
    if (amenities.isNotEmpty) {
      data["amenties"] = jsonEncode(amenities);
    }

    if (images.isNotEmpty && images.length > 1) {
      var imgs = [];
      for (var i = 0; i < images.length - 1; i++) {
        imgs.add(images[i]!.image);
      }
      data["venue_img"] = imgs;
    }

    await venueApi(data: data);
    clearForm();
  }

  void clearForm() {
    venueNameCtrl.clear();
    descCtrl.clear();
    addresCtrl.clear();
    contNumCtrl.clear();
    amenities.clear();
    images.clear();
    images.add(null);
    venueBeingEdited = null;
    isCreating = false;
    update();
  }

  Future<void> venueApi({Map? data}) async {
    debugPrint("VData $data");
    await venueRepoImp.venueApi(data!).then((response) {
      if (response.statusCode == 0) {
        getVenues();
      } else {
        showAppDialog(msg: response.msg);
      }
      clearForm();
    }).onError((error, stackTrace) {
      showAppDialog(msg: error.toString());
      clearForm();
    });
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
}

class ImageType {
  ImageType(this.image, this.type);

  String? image;
  int? type;
}

class ImageFormat {
  static const network = 0;
  static const memory = 1;
}
