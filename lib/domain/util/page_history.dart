import 'package:get/get.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';

class PageHistory {
  final NavigationHistoryObserver _observer = NavigationHistoryObserver();

  goPrevious() {
    if (_observer.poppedRoutes.isNotEmpty) {
      Get.offAndToNamed(_observer.poppedRoutes.last.settings.name!,
          arguments: _observer.poppedRoutes.last.settings.arguments);
    }
  }

  goNext() {
    if (_observer.next != null) {
      Get.toNamed(_observer.next!.settings.name!,
          arguments: _observer.next!.settings.arguments);
    }
  }

  RxBool get canPop => _observer.poppedRoutes.isNotEmpty.obs;

  RxBool get canGoNext => (_observer.next != null).obs;
}
