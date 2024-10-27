import 'package:get/get.dart';
import 'package:xpanse_app/bindings/bindings.dart';
import 'package:xpanse_app/views/auth/login.dart';
import 'package:xpanse_app/views/auth/signup.dart';
import 'package:xpanse_app/views/home/home.dart';
import 'package:xpanse_app/views/onboarding/onboarding_1.dart';
import 'package:xpanse_app/views/onboarding/onboarding_2.dart';
import 'package:xpanse_app/views/splash/splash.dart';
import 'route_names.dart';
// Import your page components and bindings here

class AppPages {
  static final List<GetPage<dynamic>> routes = [
    GetPage(
      name: RouteNames.home,
      page: () => const HomePage(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: RouteNames.login,
      page: () => LoginPage(),
    ),
    GetPage(
      name: RouteNames.signup,
      page: () => const SignUpPage(),
    ),
    GetPage(
      name: RouteNames.onboarding1,
      page: () => const OnboardingScreen(),
      // binding: ProfileBinding(),
    ),
    GetPage(
      name: RouteNames.onboarding2,
      page: () => const OnboardingScreen2(),
      // binding: ProfileBinding(),
    ),
    GetPage(
      name: RouteNames.splash,
      page: () => const SplashScreen(),
    ),
  ];
}
