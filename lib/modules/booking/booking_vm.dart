import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:harbourhouse/modules/booking/booking_model.dart';
import 'package:harbourhouse/modules/txns/txns_repo/txns_repo_impl.dart';
import 'package:harbourhouse/modules/venue/venue_vm.dart';
import 'package:harbourhouse/modules/zone/zone_vm.dart';
import 'package:intl/intl.dart';

import '../../utils/common.dart';
import '../../utils/secure_storage.dart';
import 'booking_repo/booking_repo_impl.dart';

class BookingVM extends GetxController {
  final venueVM = Get.find<VenueVM>();
  final zoneVM = Get.find<ZoneVM>();
  BookingRepoImpl bookingRepoImp = BookingRepoImpl();
  TxnsRepoImpl txnsRepoImpl = TxnsRepoImpl();
  bool? isLoading = true;
  String? userId = "", token = "", role="";
  List<Datum> bookedSlots = List.empty(growable: true);
  List<Datum> allSlots = List.empty(growable: true);
  DateTime date = DateTime.now();
  String? dateStrFrom;
  String? dateStrTo;
  List<RatesJson?> rateJson = List.empty(growable: true);
  bool? showZoneInfo = false;
  String? selectedDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  DateTime? selectedDateTime = DateTime.now();
  int selectedSlot = -1;
  bool? showPayment = false;
  double? totalPrice = 0.0;

  double minDurationRate = 0.0;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> init() async {
    userId = await SecuredStorage.readStringValue(Keys.userId);
    token = await SecuredStorage.readStringValue(Keys.token);
    role = await SecuredStorage.readStringValue(Keys.role);
    dateStrFrom = DateFormat("yyyy-MM-dd").format(date);
    dateStrTo = dateStrFrom;
    parseRateList();
    await generateSlots();
    isLoading = false;
    update();
  }

  void parseRateList() {
    rateJson.clear();
    try {
      var rj = jsonDecode(zoneVM.selectedZone!.rateJson.toString()) as List;
      for (var i = 0; i < rj.length; i++) {
        rateJson.add(RatesJson(
            hrs: rj[i]["hour"].toString(), rate: rj[i]["rate"].toString()));
      }
    } catch (e) {
      showAppDialog(msg: "Invalid data for Rate Json");
    }
    rateJson.sort((a, b) {
      return int.parse(a!.hrs!).compareTo(int.parse(b!.hrs!));
    });
    minDurationRate = double.parse(rateJson[0]!.rate!);
  }

  Future<void> generateSlots() async {
    totalPrice = 0.0;
    showPayment = false;
    var totalHrs = zoneVM
        .timeFormatFromApi(zoneVM.selectedZone!.closeTime)!
        .difference(zoneVM.timeFormatFromApi(zoneVM.selectedZone!.openTime)!)
        .inMinutes;

    int slotInMins = int.parse(zoneVM.selectedZone!.slot.toString());
    int totalSlots = (totalHrs / slotInMins).ceil();

    debugPrint(
        "Total mins : $totalHrs, mins pr slot : $slotInMins, total slots : $totalSlots");

    //10:00AM
    DateTime baseSlot =
        zoneVM.timeFormatFromApi(zoneVM.selectedZone!.openTime)!;
    DateTime firstSlotStart = DateTime(
        selectedDateTime!.year,
        selectedDateTime!.month,
        selectedDateTime!.day,
        baseSlot.hour,
        baseSlot.minute);
    DateTime? slotEndDateTime;
    allSlots.clear();
    for (var i = 0; i < totalSlots; i++) {
      slotEndDateTime = firstSlotStart.add(Duration(minutes: slotInMins));
      allSlots.add(Datum(
          bookFlag: 0,
          fromDateTime: firstSlotStart,
          fromDate: zoneVM.timeFormatHHmm(firstSlotStart),
          toDateTime: slotEndDateTime,
          toDate: zoneVM.timeFormatHHmm(slotEndDateTime)));
      firstSlotStart = slotEndDateTime; //.add(Duration(minutes: slotInMins));
    }
    await getSlots();
  }

  Future<void> getSlots() async {
    Map data = {
      "venue_num": venueVM.venue!.venueNum.toString(),
      "zone_num": zoneVM.selectedZone!.zoneNum.toString(),
      "user_num": userId.toString(),
      "from": dateStrFrom,
      "to": dateStrTo,
    };
    isLoading = true;
    update();
    bookedSlots.clear();
    debugPrint("slotList $data");
    await bookingRepoImp.bookingList(data).then((response) {
      if (response.statusCode == 0) {
        bookedSlots.addAll(response.data!);

        for (var i = 0; i < allSlots.length; i++) {
          var idx = bookedSlots.indexWhere((element) {
            debugPrint(
                "allSlotFD ${allSlots[i].fromDate}, el.FD ${element.fromDate}, allSlotTD ${allSlots[i].toDate}, el.TD ${element.toDate}  ");
            return (allSlots[i].fromDateTime ==
                    zoneVM.timeFormatFromApi(element.fromDate) &&
                allSlots[i].toDateTime ==
                    zoneVM.timeFormatFromApi(element.toDate));
          });
          if (idx != -1) {
            Datum slot = bookedSlots[idx];
            allSlots[i].slotNum = slot.slotNum!;
            allSlots[i].bookFlag = slot.bookFlag!;
            allSlots[i].doa = slot.doa;
            allSlots[i].id = slot.id;
            allSlots[i].isActive = slot.isActive;
            allSlots[i].isSelected = false;
            allSlots[i].turfName = slot.turfName;
            allSlots[i].userName = slot.userName;
            allSlots[i].userNum = slot.userNum;
          }
        }
        parseRateList();
      } else {
        // showAppDialog(msg: response.msg);
      }
      isLoading = false;
      update();
    }).onError((error, stackTrace) {
      showAppDialog(msg: error.toString());
      isLoading = false;
      update();
    });
  }

  void reset() {
    date = DateTime.now();
    dateStrFrom = DateFormat("yyyy-MM-dd").format(date);
    dateStrTo = dateStrFrom;
    rateJson = List.empty(growable: true);
    showZoneInfo = false;
    selectedDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
    selectedDateTime = DateTime.now();
    selectedSlot = -1;
    showPayment = false;
    totalPrice = 0.0;
    minDurationRate = 0.0;
  }

  Future<void> bookingApi({Map? data}) async {
    await bookingRepoImp.bookingApi(data!).then((response) async {
      if (response.statusCode == 0) {
        //User booking
        response.slotNum;
        var txnData = {};

        var txns = [];
        for (var i = 0; i < response.slotNum!.length; i++) {
          var obj = {};
          obj["slot_num"] = response.slotNum![i].toString();
          obj["amt"] = (totalPrice! / response.slotNum!.length).toString();
          txns.add(obj);
        }

        txnData["transaction"] = jsonEncode(txns);
        debugPrint("txn Data $txnData");
        await transactionApi(data: txnData);
        reset();
        generateSlots();
      } else if (response.statusCode == 1) {
        reset();
        generateSlots();
      } else {
        showAppDialog(msg: response.msg);
      }
    }).onError((error, stackTrace) {
      showAppDialog(msg: error.toString());
    });
  }

  Future<void> transactionApi({Map? data}) async {
    await txnsRepoImpl.txnsApi(data!).then((response) {
      if (response.statusCode == 0) {
      } else {
        showAppDialog(msg: response.msg);
      }
    }).onError((error, stackTrace) {
      showAppDialog(msg: error.toString());
    });
  }

  void toggleZoneInfo() {
    showZoneInfo = !showZoneInfo!;
    update();
  }

  void calculateRate() {
    int slotInMins = int.parse(zoneVM.selectedZone!.slot.toString());
    double totalTimeHrs = 0;
    totalPrice = 0;
    for (var i = 0; i < allSlots.length; i++) {
      if (allSlots[i].isSelected!) {
        totalTimeHrs = totalTimeHrs +
            allSlots[i]
                .toDateTime!
                .difference(allSlots[i].fromDateTime!)
                .inHours;
      }
    }

    //[1, 3, 4, 7]  total -> 5
    //int pefectHr = int.parse(rateJson[0]!.hrs!);
    double? otherRate = 0.0;
    for (var i = 0; i < rateJson.length; i++) {
      otherRate =
          double.parse(rateJson[i]!.rate!); //if no rate matches take last rate
      if (int.parse(rateJson[i]!.hrs!) >= totalTimeHrs) {
        debugPrint("hr ${rateJson[i]!.hrs}, rate ${rateJson[i]!.rate}");
        debugPrint("totalPrice $totalPrice");
        if (i == 0) {
          totalPrice = double.parse(rateJson[i]!.rate!) * totalTimeHrs;
        } else if (int.parse(rateJson[i]!.hrs!) == totalTimeHrs) {
          totalPrice = double.parse(rateJson[i]!.rate!) * totalTimeHrs;
        } else {
          totalPrice = double.parse(rateJson[i - 1]!.rate!) * totalTimeHrs;
        }
        debugPrint("totalPrice $totalPrice");
        break;
      }
    }
    debugPrint("total hrs $totalTimeHrs, ");
    if (totalPrice! <= 0.0 && totalTimeHrs > 0) {
      totalPrice = totalTimeHrs * otherRate!;
    }
  }

  void bookSlots() {
    var listOfSlots = [];
    for (var i = 0; i < allSlots.length; i++) {
      if (allSlots[i].isSelected!) {
        var obj = {
          "zone_num": zoneVM.selectedZone!.zoneNum.toString(),
          "venue_num": venueVM.venue!.venueNum.toString(),
          "user_num": userId.toString(),
          // "book_flag": "1",
          "from": zoneVM.timeFormatToApi(allSlots[i].fromDateTime),
          "to": zoneVM.timeFormatToApi(allSlots[i].toDateTime),
        };
        listOfSlots.add(obj);
      }
    }
    var data = {};
    data["bookings"] = jsonEncode(listOfSlots);
    if (role == "A") {
      data["self_flag"]= "1";
    }
    debugPrint("Booking data $data");
    bookingApi(data: data);
  }
}
