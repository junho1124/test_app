import 'package:dio/dio.dart';
import 'package:test_app/data/data_source/local/auth_token_box.dart';
import 'package:test_app/data/data_source/local/user_box.dart';
import 'package:test_app/data/data_source/remote/my_client.dart';
import 'package:test_app/domain/entities/login_input.dart';
import 'package:test_app/utils/logger.dart';

import '../../utils/result.dart';
import '../model/user.dart';

class UserAuthRepository {
  final _api = MyClient().client;
  final _userAuthBox = AuthTokenBox();
  final _userBox = UserBox();

  Future<Result<User>> login(LoginInput input) async {
    try {
      final response = await _api.login(input.toJson());
      await _userAuthBox.putTokens(response.tokens);
      await _userBox.putUser(response.user);
      return Result.success(response.user);
    } on DioError catch (e) {
      Log.e(e.response!.data["message"]);
      return Result.error(e.response!.data["message"]);
    } catch (e) {
      Log.e(e);
      return Result.error(e);
    }
  }

  Future refreshToken() async {
    try {
      final token = await _api.refreshAuthTokens(
          refreshToken: {"refreshToken": _userAuthBox.getRefreshToken()});
      await _userAuthBox.putTokens(token);
    } on DioError catch (e) {
      Log.e(e.response!.data["message"]);
      return Result.error(e.response!.data["message"]);
    } catch (e) {
      Log.e(e);
      return Result.error(e);
    }
  }
}
