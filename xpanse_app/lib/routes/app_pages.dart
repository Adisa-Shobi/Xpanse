import 'package:get/get.dart';
import 'package:xpanse_app/bindings/bindings.dart';
import 'package:xpanse_app/views/auth/login.dart';
import 'package:xpanse_app/views/auth/signup.dart';
import 'package:xpanse_app/views/home/home.dart';
import 'package:xpanse_app/views/onboarding/onboarding.dart';
import 'route_names.dart';
// Import your page components and bindings here

class AppPages {
  static final List<GetPage<dynamic>> routes = [
    GetPage(
      name: RouteNames.home,
      page: () => HomePage(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: RouteNames.login,
      page: () => LoginPage(),
    ),
    GetPage(
      name: RouteNames.signup,
      page: () => SignUpPage(),
    ),
    GetPage(
      name: RouteNames.onboarding,
      page: () => OnboardingPage(),
      // binding: ProfileBinding(),
    ),
  ];
}
