import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:test_app/data/repository/item_repository.dart';
import 'package:test_app/utils/dialogs.dart';
import 'package:html/parser.dart' show parse;
import 'package:test_app/utils/logger.dart';

import '../../data/model/item.dart';

class MainViewModel extends GetxController {
  final _itemRepository = ItemRepository();
  final scrollController = ScrollController();

  RxMap<Item, List<String>> items = <Item, List<String>>{}.obs;
  RxBool isLoaded = false.obs;
  RxBool isUpdate = false.obs;
  int page = 1;

  @override
  void onInit() async {
    await getItems();
    scrollController.addListener(_scrollListener);
    isLoaded.value = true;
    super.onInit();
  }

  Future getItems() async {
    final pageInfo = await _itemRepository.getItems(page);
    Log.d("page :: $page");
    await pageInfo.when(
      success: (pageInfo) async {

        items.addAll(Map.fromIterables(pageInfo.items, await readHtml(pageInfo.items.map((e) => e.body.thumbnailUrl).toList())));
        page++;
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
