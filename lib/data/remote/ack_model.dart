// To parse this JSON data, do
//
//     final ackResponseModel = ackResponseModelFromJson(jsonString);

import 'dart:convert';

AckResponseModel ackResponseModelFromJson(String str) => AckResponseModel.fromJson(json.decode(str));

String ackResponseModelToJson(AckResponseModel data) => json.encode(data.toJson());

class AckResponseModel {
    AckResponseModel({
        this.statusCode,
        this.msg,
    });

    int? statusCode;
    String? msg;

    factory AckResponseModel.fromJson(Map<String, dynamic> json) => AckResponseModel(
        statusCode: json["statusCode"],
        msg: json["msg"],
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "msg": msg,
    };
}
