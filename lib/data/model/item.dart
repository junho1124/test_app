import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_app/data/model/body.dart';
import 'package:test_app/data/model/master.dart';

part 'item.freezed.dart';
part 'item.g.dart';

@freezed
class Item with _$Item {
  factory Item({
    required Master master,
    required int before,
    required Body body,
    required String id,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}