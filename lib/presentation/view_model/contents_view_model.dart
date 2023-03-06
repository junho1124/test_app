import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class ContentsViewModel extends GetxController {
  ContentsViewModel({required this.url});

  final String url;
  final RxBool isLoaded = false.obs;

  late final WebViewController webViewController;



  @override
  void onInit() {
    PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
          allowsInlineMediaPlayback: true,
          mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{});
    } else {
      params = WebKitWebViewControllerCreationParams();
    }
    webViewController = WebViewController.fromPlatformCreationParams(params);
    webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Color(0x00000000))
      ..setNavigationDelegate(
          NavigationDelegate(onNavigationRequest: (request) {
            if (request.url.startsWith(url)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          }))
      ..loadRequest(Uri.parse(url));
    isLoaded.value = true;
    super.onInit();
  }
}