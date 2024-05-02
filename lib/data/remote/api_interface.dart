import 'package:harbourhouse/data/remote/endpoints.dart';

abstract class ApiInterface {
  static const baseUrl = Endpoints.baseUrl;

  Future post(url, data);
}
