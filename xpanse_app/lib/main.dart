// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xpanse_app/routes/route_names.dart';
import 'routes/app_pages.dart';
import 'utils/theme.dart';
import 'controllers/auth_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Xpanse',
      theme: AppTheme.lightTheme,
      initialRoute: RouteNames.onboarding,
      getPages: AppPages.routes,
      initialBinding: BindingsBuilder(() {
        Get.put(AuthController());
      }),
    );
  }
}
