import 'package:dio/dio.dart';
import 'package:test_app/data/data_source/local/auth_token_box.dart';
import 'package:test_app/data/data_source/remote/my_client.dart';
import 'package:test_app/data/model/item.dart';
import 'package:test_app/utils/logger.dart';
import 'package:test_app/utils/result.dart';

import '../model/page_info.dart';
import 'user_auth_repository.dart';

class ItemRepository {
  final _api = MyClient().client;
  final _authTokenBox = AuthTokenBox();
  final _userAuthRepository = UserAuthRepository();

  Future<Result<PageInfo>> getItems([int? page]) async {
    try {
      Log.d("page :: $page");
      final response = await _api.getItems(
          page: page ?? 1, accessToken: _authTokenBox.getAccessToken());
      return Result.success(response);
    } on DioError catch (e) {
      if (e.response!.statusCode == 401) {
        return await _userAuthRepository
            .refreshToken()
            .then((value) => getItems(page));
      } else {
        return Result.error(e.response!.data["message"]);
      }
    } catch (e) {
      Log.e(e);
      return Result.error(e);
    }
  }

  Future<Result<Item>> getItem(String id) async {
    try {
      final response = await _api.getItem(
          id: id, accessToken: _authTokenBox.getAccessToken());
      return Result.success(response);
    } on DioError catch (e) {
      if (e.response!.statusCode == 401) {
        return await _userAuthRepository
            .refreshToken()
            .then((value) => getItem(id));
      } else {
        return Result.error(e.response!.data["message"]);
      }
    } catch (e) {
      Log.e(e);
      return Result.error(e);
    }
  }
}
