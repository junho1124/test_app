import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_app/data/model/auth_token.dart';
import 'package:test_app/data/model/token.dart';
import 'package:test_app/data/model/user.dart';



class HiveService {
  HiveService();

  static Future init() async {
    // Device 내부의 directory 를 찾아 연결
    final directory = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(directory.path);
    _addAdapter();
    await _openBox();
  }

  /// 사용 할 Hive 박스들을 open
  static Future _openBox() async {
    await Hive.openBox<AuthToken>(AuthToken.boxName);
    await Hive.openBox<User>(User.boxName);
  }

  /// Hive 객체들의 adapter 를 등록
  static void _addAdapter() {
    Hive.registerAdapter(TokenAdapter()); // 0
    Hive.registerAdapter(AuthTokenAdapter()); // 1
    Hive.registerAdapter(UserAdapter()); // 2
    Hive.registerAdapter(RoleAdapter());
  }
}
