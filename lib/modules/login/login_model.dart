// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  LoginResponseModel({
    this.statusCode,
    this.result,
    this.msg,
  });

  int? statusCode;
  Result? result;
  String? msg;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        statusCode: json["statusCode"],
        result: Result.fromJson(json["result"] ?? {}),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "result": result?.toJson(),
        "msg": msg,
      };
}

class Result {
  Result({
    this.userNum,
    this.contNum,
    this.name,
    this.email,
    this.role,
    this.img,
    this.walletBal,
    this.refreshToken,
    this.accessToken,
  });

  int? userNum;
  int? contNum;
  String? name;
  String? email;
  String? role;
  String? img;
  int? walletBal;
  String? refreshToken;
  String? accessToken;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        userNum: json["user_num"],
        contNum: json["cont_num"],
        name: json["name"],
        email: json["email"],
        role: json["role"],
        img:  json["img"],
        walletBal: json["wallet_bal"],
        refreshToken: json["refresh_token"],
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "user_num": userNum,
        "cont_num": contNum,
        "name": name,
        "email": email,
        "role": role,
        "wallet_bal": walletBal,
        "refresh_token": refreshToken,
        "access_token": accessToken,
      };
}
