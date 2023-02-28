import 'package:flutter/material.dart';
import 'package:test_app/presentation/widget/bottom_nav_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ContentsPage extends StatelessWidget {
  const ContentsPage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("콘텐츠 페이지"),
        centerTitle: true,
      ),
      bottomNavigationBar: const BottomNavBar(),
      body: WebViewWidget(controller: controller),
    );
  }
}
