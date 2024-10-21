import 'package:get/get.dart';

class HomeController extends GetxController {
  var currentIndex = 1.obs;

  void changeIndex(int index) {
    print(index);
    currentIndex.value = index;
  }
}
