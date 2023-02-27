import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_app/data/model/auth_token.dart';
import 'package:test_app/data/model/user.dart';

part 'login_result.freezed.dart';
part 'login_result.g.dart';

@freezed
class LoginResult with _$LoginResult {
  factory LoginResult({
    required User user,
    required AuthToken tokens,
  }) = _LoginResult;

  factory LoginResult.fromJson(Map<String, dynamic> json) => _$LoginResultFromJson(json);
}