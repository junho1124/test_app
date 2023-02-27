import 'package:dio/dio.dart';
import 'package:test_app/data/data_source/local/auth_token_box.dart';
import 'package:test_app/data/data_source/remote/my_client.dart';
import 'package:test_app/domain/login_input.dart';
import 'package:test_app/utils/logger.dart';

import '../../utils/result.dart';
import '../model/user.dart';

class UserAuthRepository {
  final _api = MyClient().client;
  final _userAuthBox = AuthTokenBox();

  Future<Result<User>> login(LoginInput input) async {
    try {
      final response = await _api.login(input.toJson());
      await _userAuthBox.putTokens(response.tokens);
      return Result.success(response.user);
    } on DioError catch (e) {
      Log.e(e.message);
      return Result.error(e);
    }
  }
}
