import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:harbourhouse/utils/app_service.dart';

import '../main.dart';
import '../resources/app_strings.dart';

Future getToNamed(String? page) async {
  return await Get.toNamed(page!);
}

void getOffNamed(String? page) {
  Get.offNamed(page!);
}

BuildContext getContext() {
  return locator<AppService>().navigatorKey.currentContext!;
}

void showAppDialog({String? msg, String? btnText, VoidCallback? onPressed}) {
  showCupertinoDialog<void>(
    context: getContext(),
    builder: (BuildContext context) => CupertinoAlertDialog(
      content: Text(
        msg ?? "",
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      actions: onPressed != null
          ? [
              CupertinoDialogAction(
                onPressed: onPressed,
                child: Text(btnText ?? AppStrings.okay),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(AppStrings.cancel),
              )
            ]
          : [
              CupertinoDialogAction(
                onPressed: onPressed ??
                    () {
                      Navigator.pop(context);
                    },
                child: Text(btnText ?? AppStrings.okay),
              ),
              //const CupertinoDialogAction(child:  SizedBox(width: 1,height: 1,),)
            ],
    ),
  );
}

bool isValidString(dynamic s) {
  return (s != null &&
      s.toString().trim().isNotEmpty &&
      s.toString().trim() != "null");
}
