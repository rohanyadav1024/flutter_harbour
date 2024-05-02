import 'package:harbourhouse/data/remote/ack_model.dart';

import '../booking_model.dart';

abstract class BookingRepo {
  Future<SlotsBookingResponseModel> bookingApi(Map data);
  Future<SlotsResponseModel> bookingList(Map data);
}
