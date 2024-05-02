import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:harbourhouse/data/remote/api_interface.dart';
import 'package:http/http.dart' as http;

class ApiService extends ApiInterface {
  @override
  Future post(url, data) async {
    final client = http.Client();
    http.Response response = await client.post(
        Uri.parse(ApiInterface.baseUrl + url),
        body: jsonEncode(data),
        headers: {
          "Content-Type": "Application/json"
        }); //
    debugPrint("RESPONSE $url, ${response.body}");
    return //jsonDecode(
        response.body; //);
  }
}
