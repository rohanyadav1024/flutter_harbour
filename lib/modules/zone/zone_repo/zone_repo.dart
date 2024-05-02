import 'package:harbourhouse/data/remote/ack_model.dart';
import 'package:harbourhouse/modules/zone/zone_model.dart';

abstract class ZoneRepo {
  Future<ZonesResponseModel> getZones(Map data);
  Future<AckResponseModel> zoneApi(Map data);
}
