import 'package:hive/hive.dart';
import 'package:test_app/data/model/auth_token.dart';

class AuthTokenBox {
  final Box<AuthToken> _authTokenBox = Hive.box(AuthToken.boxName);

  Future putTokens(AuthToken token) async {
    await _authTokenBox.put("authToken", token);
  }
}