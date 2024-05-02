import 'package:harbourhouse/data/remote/ack_model.dart';
import 'package:harbourhouse/data/remote/api_service.dart';
import 'package:harbourhouse/data/remote/endpoints.dart';
import 'package:harbourhouse/modules/venue/venue_repo/venue_repo.dart';
import 'package:harbourhouse/modules/venue/venues_model.dart';

class VenueRepoImp extends VenueRepo {
  ApiService apiService = ApiService();

  @override
  Future<VenuesResponseModel> getVenues(Map data) async {
    return venuesResponseModelFromJson(
        await apiService.post(Endpoints.venue + Endpoints.venueList, data));
  }

  @override
  Future<AckResponseModel> venueApi(Map data) async {
    return ackResponseModelFromJson(
        await apiService.post(Endpoints.venue + Endpoints.venueApis, data));
  }
}
