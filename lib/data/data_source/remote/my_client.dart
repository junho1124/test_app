import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:test_app/data/model/login_result.dart';

import '../../model/auth_token.dart';
import '../../model/item.dart';
import '../../model/page_info.dart';

part 'my_client.g.dart';

@RestApi(baseUrl: "http://test.us-all.co.kr/v1")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("/auth/login")
  Future<LoginResult> login(@Body() Map<String, dynamic> data);

  @POST("/auth/logout")
  Future logout({@Body() required String refreshToken});

  @POST("/auth/refresh-tokens")
  Future<AuthToken> refreshAuthTokens({@Body() required Map<String, dynamic> refreshToken});

  @GET("/contents/items")
  Future<PageInfo> getItems(
      {@Query("sortBy") String sortBy = "name:asc",
      @Query("limit") int limit = 5,
      @Query("page") int page,
        @Header("Authorization") required String accessToken,
      });

  @GET("/contents/item/{id}")
  Future<Item> getItem({
    @Path("id") required String id,
    @Header("Authorization") required String accessToken,
  });
}

class MyClient {
  final client = RestClient(Dio(BaseOptions(receiveDataWhenStatusError: true)),
      baseUrl: "http://test.us-all.co.kr/v1");
}
