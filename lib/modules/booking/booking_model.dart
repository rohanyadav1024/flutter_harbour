// To parse this JSON data, do
//
//     final slotsResponseModel = slotsResponseModelFromJson(jsonString);

import 'dart:convert';

SlotsResponseModel slotsResponseModelFromJson(String str) =>
    SlotsResponseModel.fromJson(json.decode(str));

String slotsResponseModelToJson(SlotsResponseModel data) =>
    json.encode(data.toJson());

class SlotsResponseModel {
  SlotsResponseModel({
    this.statusCode,
    this.data,
    this.msg,
  });

  int? statusCode;
  List<Datum>? data;
  String? msg;

  factory SlotsResponseModel.fromJson(Map<String, dynamic> json) =>
      SlotsResponseModel(
        statusCode: json["statusCode"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "msg": msg,
      };
}

class Datum {
  Datum({
    this.id,
    this.slotNum,
    this.userNum,
    this.venueNum,
    this.zoneNum,
    this.fromDate,
    this.fromDateTime,
    this.toDate,
    this.toDateTime,
    this.doa,
    this.isActive,
    this.venueName,
    this.turfName,
    this.userName,
    this.bookFlag,
  });

  int? id;
  int? slotNum;
  int? userNum;
  int? venueNum;
  int? zoneNum;
  String? fromDate;
  DateTime? fromDateTime;
  String? toDate;
  DateTime? toDateTime;
  String? doa;
  String? isActive;
  String? venueName;
  String? turfName;
  String? userName;
  int? bookFlag;
  bool? isSelected = false;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
      id: json["id"],
      slotNum: json["slot_num"],
      userNum: json["user_num"],
      venueNum: json["venue_num"],
      zoneNum: json["zone_num"],
      fromDate: json["from_date"],
      toDate: json["to_date"],
      doa: json["doa"],
      isActive: json["is_active"],
      venueName: json["venue_name"],
      turfName: json["turf_name"],
      userName: json["user_name"],
      bookFlag: json["book_flag"] ?? 0);

  Map<String, dynamic> toJson() => {
        "id": id,
        "slot_num": slotNum,
        "user_num": userNum,
        "venue_num": venueNum,
        "zone_num": zoneNum,
        "from_date": fromDate,
        "to_date": toDate,
        "doa": doa,
        "is_active": isActive,
        "venue_name": venueName,
        "turf_name": turfName,
        "user_name": userName,
      };
}

// To parse this JSON data, do
//
//     final slotsBookingResponseModel = slotsBookingResponseModelFromJson(jsonString);

SlotsBookingResponseModel slotsBookingResponseModelFromJson(String str) => SlotsBookingResponseModel.fromJson(json.decode(str));

String slotsBookingResponseModelToJson(SlotsBookingResponseModel data) => json.encode(data.toJson());

class SlotsBookingResponseModel {
    SlotsBookingResponseModel({
        this.statusCode,
        this.slotNum,
        this.msg,
    });

    int? statusCode;
    List<int>? slotNum;
    String? msg;

    factory SlotsBookingResponseModel.fromJson(Map<String, dynamic> json) => SlotsBookingResponseModel(
        statusCode: json["statusCode"],
        slotNum: json["slot_num"] == null ? [] : List<int>.from(json["slot_num"]!.map((x) => x)),
        msg: json["msg"],
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "slot_num": slotNum == null ? [] : List<dynamic>.from(slotNum!.map((x) => x)),
        "msg": msg,
    };
}

