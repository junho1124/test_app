import 'package:get/get.dart';
import 'package:test_app/domain/util/page_history.dart';

class BottomNavViewModel extends GetxController {
  final PageHistory _history = PageHistory();

  RxBool get canPop => _history.canPop;

  RxBool get canGoNext => _history.canGoNext;

  @override
  void onInit() {
    _history.addRouteListener();
    super.onInit();
  }
  
  void changePage(int index) {
    if (index == 0 && canPop.isTrue) {
      _history.goPrevious();
    } else if (index == 1 && canGoNext.isTrue) {
      _history.goNext();
    }
  }
}
