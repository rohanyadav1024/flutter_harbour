import 'package:harbourhouse/data/remote/ack_model.dart';
import 'package:harbourhouse/modules/venue/venues_model.dart';

abstract class VenueRepo {
  Future<AckResponseModel> venueApi(Map data);
  Future<VenuesResponseModel> getVenues(Map data);
}
