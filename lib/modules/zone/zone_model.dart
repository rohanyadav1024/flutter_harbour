// To parse this JSON data, do
//
//     final zonesResponseModel = zonesResponseModelFromJson(jsonString);

import 'dart:convert';

ZonesResponseModel zonesResponseModelFromJson(String str) =>
    ZonesResponseModel.fromJson(json.decode(str));

String zonesResponseModelToJson(ZonesResponseModel data) =>
    json.encode(data.toJson());

class ZonesResponseModel {
  ZonesResponseModel({
    this.statusCode,
    this.data,
    this.msg,
  });

  int? statusCode;
  List<Datum>? data;
  String? msg;

  factory ZonesResponseModel.fromJson(Map<String, dynamic> json) =>
      ZonesResponseModel(
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
    this.zoneNum,
    this.venueNum,
    this.name,
    this.rateJson,
    this.zoneImg,
    this.isActive,
    this.doa,
    this.discription,
    this.openTime,
    this.closeTime,
    this.slot,
  });

  int? id;
  int? zoneNum;
  int? venueNum;
  String? name;
  String? rateJson;
  List<String>? zoneImg;
  String? isActive;
  String? doa;
  String? discription;
  String? openTime;
  String? closeTime;
  dynamic slot;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
      id: json["id"],
      zoneNum: json["zone_num"],
      venueNum: json["venue_num"],
      name: json["name"],
      rateJson: json["rate_json"],
      zoneImg: json["zone_img"] == null
          ? []
          : json["zone_img"] is String
              ? jsonDecode(json["zone_img"]) is List
                  ? List<String>.from(
                      jsonDecode(json["zone_img"])!.map((x) => x))
                  : []
              : List<String>.from(json["zone_img"]!.map((x) => x)),
      isActive: json["is_active"],
      doa: json["doa"],
      discription: json["discription"],
      openTime: json["open_time"],
      closeTime: json["close_time"],
      slot: json["slot"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "zone_num": zoneNum,
        "venue_num": venueNum,
        "name": name,
        "rate_json": rateJson,
        // "zone_img": zoneImg,
        "is_active": isActive,
        "doa": doa,
      };
}
