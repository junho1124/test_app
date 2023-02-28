import 'package:get/get.dart';

class BottomNavViewModel extends GetxController {
  RxBool canPop = false.obs;

  Map<int, String> routeHistory = {};
  void changePage(int index) {
    if (index == 0) {
      canPop.isTrue ? Get.back() : null;
    } else {

    }
    notifyChildrens();
  }
}
