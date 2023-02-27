import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

enum Role {
  user,
  admin
}

@freezed
class User with _$User {
  factory User({
    required String id,
    required String email,
    required String name,
    required Role role,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}