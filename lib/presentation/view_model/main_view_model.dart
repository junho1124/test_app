import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:test_app/data/model/body.dart';
import 'package:test_app/data/repository/item_repository.dart';
import 'package:test_app/presentation/view/contens_page/contents_page.dart';
import 'package:test_app/presentation/view/video_page/video_page.dart';
import 'package:test_app/utils/dialogs.dart';
import 'package:html/parser.dart' show parse;
import 'package:test_app/utils/logger.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../data/model/item.dart';
import '../view/audio_page/audio_page.dart';

class MainViewModel extends GetxController {
  final _itemRepository = ItemRepository();
  final scrollController = ScrollController();
  WebViewController? webViewController;

  RxMap<Item, List<String>> items = <Item, List<String>>{}.obs;
  RxBool isLoaded = false.obs;
  RxBool isUpdate = false.obs;
  int page = 1;

  @override
  void onInit() async {
    await getItems();
    scrollController.addListener(_scrollListener);
    super.onInit();
  }

  Future getItems() async {
    final pageInfo = await _itemRepository.getItems(page);
    Log.d("page :: $page");
    await pageInfo.when(
      success: (pageInfo) async {
        items.addAll(Map.fromIterables(
            pageInfo.items,
            await readHtml(
                pageInfo.items.map((e) => e.body.thumbnailUrl).toList())));
        page++;
        isLoaded.value = true;
      },
      error: (e) {
        simpleDialog(title: "에러", contents: Text(e.toString()));
      },
    );
  }

  void _scrollListener() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isUpdate.value = true;
      await getItems();
      isUpdate.value = false;
    }
  }

  void goDetail(Item item) {
    switch(item.body.type) {
      case Type.Link:
        _goContents(item);
        break;
      case Type.VOD:
        Get.toNamed(VideoPage.path, arguments: item);
        break;
      case Type.Audio:
        Get.toNamed(AudioPage.path, arguments: item);
        break;
    }
  }

  void _goContents(Item item) {
    PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
          allowsInlineMediaPlayback: true,
          mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{});
    } else {
      params = WebKitWebViewControllerCreationParams();
    }
    webViewController = WebViewController.fromPlatformCreationParams(params);
    webViewController!
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Color(0x00000000))
      ..setNavigationDelegate(
          NavigationDelegate(onNavigationRequest: (request) {
        if (request.url.startsWith(item.body.url)) {
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      }))
      ..loadRequest(Uri.parse(item.body.url));
    Get.toNamed(ContentsPage.path, arguments: webViewController);
  }

  Future<List<List<String>>> readHtml(List<String> urls) async {
    List<List<String>> data = [];
    for (String url in urls) {
      final response = await Dio().get(url);
      var document = parse(response.data);

      String title =
          document.getElementsByClassName("media_end_head_headline").first.text;
      String writer =
          document.getElementsByClassName("byline_p").first.text.trim();
      String imageUrl = document
          .getElementsByClassName("end_photo_org")
          .first
          .getElementsByTagName("img")
          .first
          .outerHtml
          .split('"')[3];
      data.add([title, writer, imageUrl]);
    }
    return data;
  }

  @override
  void onClose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.onClose();
  }
}
