import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:harbourhouse/modules/base/base_view.dart';
import 'package:harbourhouse/modules/booking/booking_view.dart';
import 'package:harbourhouse/modules/login/login_view/login_view.dart';
import 'package:harbourhouse/modules/login/login_view/otp_view.dart';
import 'package:harbourhouse/modules/zone/zone_view.dart';
import 'package:harbourhouse/resources/app_routes.dart';
import 'package:harbourhouse/resources/app_strings.dart';
import 'package:harbourhouse/utils/app_service.dart';
import 'package:harbourhouse/utils/bindings.dart';
import 'package:harbourhouse/utils/secure_storage.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AppService());
}

void main() {
  setupLocator();
  SecuredStorage.initiateSecureStorage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: locator<AppService>().navigatorKey,
      initialRoute: AppRoutes.login,
      getPages: [
        GetPage(
            name: AppRoutes.login,
            page: () => const LoginView(),
            binding: LoginBinding()),
        GetPage(
          name: AppRoutes.otp,
          page: () => const OtpView(),
        ),
        GetPage(
            name: AppRoutes.base,
            page: () => const BaseView(),
            binding: BaseBinding()),
        GetPage(
            name: AppRoutes.zone,
            page: () => const ZoneView(),
            binding: ZoneBinding()),
        GetPage(
            name: AppRoutes.booking,
            page: () => const BookingView(),
            binding: BookingBinding()),        
            
      ],
    );
  }
}
