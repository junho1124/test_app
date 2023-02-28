import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@HiveType(typeId: 3)
enum Role {
  @HiveField(0)
  user,
  @HiveField(1)
  admin
}

@freezed
class User with _$User {
  static const boxName = "user";

  @HiveType(typeId: 2)
  factory User({
    @HiveField(0) required String id,
    @HiveField(1) required String email,
    @HiveField(2) required String name,
    @HiveField(3) required Role role,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
