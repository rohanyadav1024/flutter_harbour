import 'package:get/get.dart';

import '../../utils/common.dart';
import '../../utils/secure_storage.dart';
import 'txns_repo/txns_repo_impl.dart';

class TxnsVM extends GetxController {
  TxnsRepoImpl txnsRepoImp = TxnsRepoImpl();
  bool? isLoading = true;
  String? userId = "", token = "";
  List<dynamic> txns = List.empty(growable: true);

  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> init() async {
    userId = await SecuredStorage.readStringValue(Keys.userId);
    token = await SecuredStorage.readStringValue(Keys.token);
    await getTxns();
    isLoading = false;
    update();
  }

  Future<void> getTxns() async {
    //Map data = {};
    isLoading = true;
    update();
    txns.clear();
    await txnsRepoImp.getTxns({}).then((response) {
      if (response.statusCode == 0) {
        txns.addAll(response.data!);
      } else {
        showAppDialog(msg: response.msg);
      }
      isLoading = true;
    update();
    }).onError((error, stackTrace) {
      showAppDialog(msg: error.toString());
      isLoading = true;
    update();
    });
  }

  Future<void> txnsApi({Map? data}) async {
    await txnsRepoImp.txnsApi(data!).then((response) {
      if (response.statusCode == 0) {
        getTxns();
      } else {
        showAppDialog(msg: response.msg);
      }
    }).onError((error, stackTrace) {
      showAppDialog(msg: error.toString());
    });
  }
}