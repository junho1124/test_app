import 'package:hive/hive.dart';
import 'package:test_app/data/model/user.dart';

class UserBox {
  final Box<User> _userBox = Hive.box(User.boxName);

  Future putUser(User user) async {
    await _userBox.put(User.boxName, user);
    await _userBox.flush();
  }
}