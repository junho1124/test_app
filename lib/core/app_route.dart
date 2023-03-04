import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/presentation/view/audio_page/audio_page.dart';
import 'package:test_app/presentation/view/contens_page/contents_page.dart';
import 'package:test_app/presentation/view/login_page/login_page.dart';
import 'package:test_app/presentation/view/main_page/main_page.dart';
import 'package:test_app/presentation/view/video_page/video_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../data/model/item.dart';
import '../utils/logger.dart';

class AppRoutes {
  static Route<dynamic>? onGenerateRoutes(RouteSettings settings) {
    Log.d(settings.name);
    switch (settings.name) {
      case LoginPage.path:
        return _getRoute(const LoginPage(), settings.name);
      case MainPage.path:
        return _getRoute(const MainPage(), settings.name);
      case ContentsPage.path:
        final WebViewController controller = settings.arguments as WebViewController;
        return _getRoute(ContentsPage(controller: controller), settings.name);
      case VideoPage.path:
        final Item item = settings.arguments as Item;
        return _getRoute(VideoPage(item: item), settings.name);
      case AudioPage.path:
        final Item item = settings.arguments as Item;
        return _getRoute(AudioPage(item: item), settings.name);
      default:
        return _getRoute(const MainPage(), settings.name);
    }
  }

  static Route<dynamic>? _getRoute(Widget view, String? routeName) {
    return GetPageRoute(page: () => view, routeName: routeName);
  }
}
