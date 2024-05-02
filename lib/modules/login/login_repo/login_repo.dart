import 'package:harbourhouse/modules/login/login_model.dart';

abstract class LoginRepo {
  Future<LoginResponseModel> login(Map data);
}
