import 'package:get/get.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:test_app/utils/logger.dart';

class PageHistory {
  final NavigationHistoryObserver _observer = NavigationHistoryObserver();

  goPrevious() {
    canPop.isTrue ? Get.back(closeOverlays: true) : null;
  }

  goNext() {
    canGoNext.isTrue
        ? Get.toNamed(_observer.next!.settings.name!,
            arguments: _observer.next!.settings.arguments)
        : null;
  }

  RxBool canPop = false.obs;

  RxBool canGoNext = false.obs;

  addRouteListener() {
    _observer.historyChangeStream.listen((event) {
      canPop.value = _observer.history.length > 1;
      Log.d("history :: ${_observer.history.toString()}");
      Log.d("poppedRoute :: ${_observer.poppedRoutes.toString()}");
      canGoNext.value = _observer.next != null &&
          _observer.poppedRoutes.last.settings.name !=
              _observer.top!.settings.name;
    });
  }
}
