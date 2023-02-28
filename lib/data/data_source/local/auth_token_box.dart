import 'package:hive/hive.dart';
import 'package:test_app/data/model/auth_token.dart';

class AuthTokenBox {
  final Box<AuthToken> _authTokenBox = Hive.box(AuthToken.boxName);

  Future putTokens(AuthToken token) async {
    await _authTokenBox.put(AuthToken.boxName, token);
    await _authTokenBox.flush();
  }

  String getAccessToken() {
    final token = _authTokenBox.get(AuthToken.boxName);
    if(token != null) {
      return "Bearer ${token.access.token}";
    } else {
      return "";
    }
  }

  String getRefreshToken() {
    final token = _authTokenBox.get(AuthToken.boxName);
    if(token != null) {
      return token.refresh.token;
    } else {
      return "";
    }
  }

  Future deleteTokens() async {
    await _authTokenBox.clear();
  }
}