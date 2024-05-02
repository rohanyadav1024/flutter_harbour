import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harbourhouse/modules/txns/txns_vm.dart';

import '../../utils/widgets/loader_no_data.dart';

class TxnsView extends StatelessWidget {
  const TxnsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TxnsVM>(builder: (c) {
      return Scaffold(
          body: c.isLoading!
              ? const Loader()
              : c.txns.isEmpty
                  ? const NoData()
                  : ListView.builder(
                      itemCount: c.txns.length,
                      itemBuilder: (context, index) {
                        return Container();
                      },
                    ));
    });
  }
}