import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:test_app/data/model/login_result.dart';

import '../../model/auth_token.dart';


part 'my_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("/auth/login")
  Future<LoginResult> login(@Body() Map<String, dynamic> data);

  @POST("/auth/logout")
  Future logout({@Body() required String refreshToken});

  @POST("/auth/refresh-tokens")
  Future<AuthToken> refreshAuthTokens({@Body() required String refreshToken});


}

class MyClient {
  final client = RestClient(Dio(), baseUrl: "http://test.us-all.co.kr/v1");
}
