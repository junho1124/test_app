import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:test_app/data/model/token.dart';

part 'auth_token.freezed.dart';
part 'auth_token.g.dart';

@freezed
class AuthToken with _$AuthToken {
  static const String boxName = "authToken";
  @HiveType(typeId: 1)
  factory AuthToken({
    @HiveField(0)
    required Token access,
    @HiveField(1)
    required Token refresh,
  }) = _AuthToken;

  factory AuthToken.fromJson(Map<String, dynamic> json) => _$AuthTokenFromJson(json);
}