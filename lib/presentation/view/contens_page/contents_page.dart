import 'package:flutter/material.dart';
import 'package:test_app/data/model/item.dart';

class ContentsPage extends StatelessWidget {
  const ContentsPage({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("콘텐츠 페이지"),
        centerTitle: true,
      ),
    );
  }
}
