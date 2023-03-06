import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/presentation/view/audio_page/audio_page.dart';
import 'package:test_app/presentation/view/contens_page/contents_page.dart';
import 'package:test_app/presentation/view/login_page/login_page.dart';
import 'package:test_app/presentation/view/main_page/main_page.dart';
import 'package:test_app/presentation/view/video_page/video_page.dart';

class AppRoutes {
  static Route<dynamic>? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case LoginPage.path:
        return _getRoute(const LoginPage(), settings);
      case MainPage.path:
        return _getRoute(const MainPage(), settings);
      case ContentsPage.path:
        final String url = settings.arguments as String;
        return _getRoute(ContentsPage(url: url), settings);
      case VideoPage.path:
        final String url = settings.arguments as String;
        return _getRoute(VideoPage(url: url), settings);
      case AudioPage.path:
        final String url = settings.arguments as String;
        return _getRoute(AudioPage(url: url), settings);
      default:
        return _getRoute(const MainPage(), settings);
    }
  }

  static Route<dynamic>? _getRoute(Widget view, RouteSettings settings) {
    return GetPageRoute(page: () => view, settings: settings);
  }
}
