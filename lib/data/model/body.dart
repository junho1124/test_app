import 'package:freezed_annotation/freezed_annotation.dart';

part 'body.freezed.dart';
part 'body.g.dart';

enum Type {
  Link,
  VOD,
  Audio
}

@freezed
class Body with _$Body {
  factory Body({
    required Type type,
    @JsonKey(name: "thumbnail_url")
    required String thumbnailUrl,
    required String url
  }) = _Body;

  factory Body.fromJson(Map<String, dynamic> json) => _$BodyFromJson(json);
}