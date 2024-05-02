import 'package:harbourhouse/data/remote/ack_model.dart';

abstract class TxnsRepo {
  Future<AckResponseModel> txnsApi(Map data);
  Future/*<TxnsReponseModel>*/ getTxns(Map data);
}
