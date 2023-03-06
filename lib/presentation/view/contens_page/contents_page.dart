import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/presentation/view_model/contents_view_model.dart';
import 'package:test_app/presentation/widget/bottom_nav_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../widget/loading_indicator.dart';

class ContentsPage extends StatelessWidget {
  const ContentsPage({
    Key? key,
    required this.url,
  }) : super(key: key);
  static const String path = "/ContentsPage";

  final String url;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContentsViewModel>(
        init: ContentsViewModel(url: url),
        builder: (vm) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("콘텐츠 페이지"),
              centerTitle: true,
            ),
            bottomNavigationBar: const BottomNavBar(),
            body: vm.isLoaded.isTrue
                ? WebViewWidget(controller: vm.webViewController)
                : const LoadingIndicator(),
          );
        });
  }
}

