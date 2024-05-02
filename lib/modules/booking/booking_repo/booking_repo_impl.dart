import 'package:harbourhouse/data/remote/ack_model.dart';
import 'package:harbourhouse/data/remote/api_service.dart';
import 'package:harbourhouse/data/remote/endpoints.dart';
import 'package:harbourhouse/modules/booking/booking_repo/booking_repo.dart';

import '../booking_model.dart';

class BookingRepoImpl extends BookingRepo {
  ApiService apiService = ApiService();
  @override
  Future<SlotsBookingResponseModel> bookingApi(Map data) async {
    return slotsBookingResponseModelFromJson(
        await apiService.post(Endpoints.booking + Endpoints.slotApis, data));
  }

  @override
  Future<SlotsResponseModel> bookingList(Map data) async {
    return slotsResponseModelFromJson(
        await apiService.post(Endpoints.booking + Endpoints.slotList, data));
  }
}
