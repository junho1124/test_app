import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_app/data/model/item.dart';

part 'page_info.freezed.dart';
part 'page_info.g.dart';

@freezed
class PageInfo with _$PageInfo {
  factory PageInfo({
    @JsonKey(name: "results") required List<Item> items,
    required int page,
    required int limit,
    required int totalPages,
    required int totalResults,
  }) = _PageInfo;

  factory PageInfo.fromJson(Map<String, dynamic> json) => _$PageInfoFromJson(json);
}