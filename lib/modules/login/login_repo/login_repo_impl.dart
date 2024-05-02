import 'package:harbourhouse/data/remote/api_service.dart';
import 'package:harbourhouse/data/remote/endpoints.dart';
import 'package:harbourhouse/modules/login/login_model.dart';
import 'package:harbourhouse/modules/login/login_repo/login_repo.dart';

class LoginRepoImpl extends LoginRepo {
  ApiService apiService = ApiService();

  @override
  Future<LoginResponseModel> login(Map data) async {
    return loginResponseModelFromJson(
        await apiService.post(Endpoints.user + Endpoints.login, data));
  }
}
