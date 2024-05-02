// To parse this JSON data, do
//
//     final venuesResponseModel = venuesResponseModelFromJson(jsonString);


//data >> repo >> model >> viewmodel >> loginpage
//model


import 'dart:convert';

VenuesResponseModel venuesResponseModelFromJson(String str) => VenuesResponseModel.fromJson(json.decode(str));

String venuesResponseModelToJson(VenuesResponseModel data) => json.encode(data.toJson());

class VenuesResponseModel {
    VenuesResponseModel({
        this.statusCode,
        this.data,
        this.msg,
    });

    int? statusCode;
    List<Datum>? data;
    String? msg;

    factory VenuesResponseModel.fromJson(Map<String, dynamic> json) => VenuesResponseModel(
        statusCode: json["statusCode"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        msg: json["msg"],
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "msg": msg,
    };
}

class Datum {
    Datum({
        this.id,
        this.venueNum,
        this.name,
        this.venueImg,
        this.address,
        this.discription,
        this.contNumber,
        this.doa,
        this.isActive,
        this.amenties,
    });

    int? id;
    int? venueNum;
    String? name;
    List<String>? venueImg;
    String? address;
    String? discription;
    int? contNumber;
    String? doa;
    String? isActive;
    String? amenties;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        venueNum: json["venue_num"],
        name: json["name"]??"",
        venueImg: json["venue_img"] == null ? [] : List<String>.from(json["venue_img"]!.map((x) => x)),
        address: json["address"]??"",
        discription: json["discription"]??"",
        contNumber: json["cont_number"],
        doa: json["doa"],
        isActive: json["is_active"],
        amenties: json["amenties"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "venue_num": venueNum,
        "name": name,
        "venue_img": venueImg == null ? [] : List<dynamic>.from(venueImg!.map((x) => x)),
        "address": address,
        "discription": discription,
        "cont_number": contNumber,
        "doa": doa,
        "is_active": isActive,
        "amenties": amenties,
    };
}
