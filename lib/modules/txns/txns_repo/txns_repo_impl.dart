import 'package:harbourhouse/data/remote/ack_model.dart';
import 'package:harbourhouse/data/remote/api_service.dart';
import 'package:harbourhouse/data/remote/endpoints.dart';
import 'package:harbourhouse/modules/txns/txns_repo/txns_repo.dart';

class TxnsRepoImpl extends TxnsRepo {
  ApiService apiService = ApiService();
  @override
  Future getTxns(Map data) async {
    return /*txnsReponseModelFromJson(*/ await apiService.post(
        Endpoints.transaction + Endpoints.txnList, data); //);
  }

  @override
  Future<AckResponseModel> txnsApi(Map data) async {
    return ackResponseModelFromJson(
        await apiService.post(Endpoints.transaction + Endpoints.txnApis, data));
  }
}
