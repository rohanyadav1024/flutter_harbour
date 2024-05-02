import 'package:harbourhouse/data/remote/api_service.dart';
import 'package:harbourhouse/data/remote/endpoints.dart';
import 'package:harbourhouse/modules/zone/zone_model.dart';
import 'package:harbourhouse/data/remote/ack_model.dart';
import 'package:harbourhouse/modules/zone/zone_repo/zone_repo.dart';

class ZoneRepoImpl extends ZoneRepo {
  ApiService apiService = ApiService();
  @override
  Future<ZonesResponseModel> getZones(Map data) async {
    return zonesResponseModelFromJson(
        await apiService.post(Endpoints.zone + Endpoints.zoneList, data));
  }

  @override
  Future<AckResponseModel> zoneApi(Map data) async {
    return ackResponseModelFromJson(
        await apiService.post(Endpoints.zone + Endpoints.zoneApis, data));
  }
}
