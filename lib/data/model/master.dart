import 'package:freezed_annotation/freezed_annotation.dart';

part 'master.freezed.dart';
part 'master.g.dart';

@freezed
class Master with _$Master {
  factory Master({
    required String icon,
    required String name,
    required String description,
  }) = _Master;

  factory Master.fromJson(Map<String, dynamic> json) => _$MasterFromJson(json);
}