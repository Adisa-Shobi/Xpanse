import 'package:get/get.dart';
import 'package:xpanse_app/controllers/home_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => {
        HomeController(),
      },
    );
  }
}
