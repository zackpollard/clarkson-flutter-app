import 'package:clarkson/http/utils.dart';
import 'package:clarkson/models/responses/user_response.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:corsac_jwt/corsac_jwt.dart';


class UserApiProvider {
  final String _endpoint = "https://clarkson.zackpollard.pro/api/user/";
  Dio _dio;

  UserApiProvider() {
    _dio = Dio();
    _setupInterceptor();
  }

  void _setupInterceptor() {
    _dio.interceptors.add(Utils.getAuthenticationInterceptor(_dio));
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String userId = JWT.parse(prefs.getString("access_token")).claims['id'];
        options.path += userId;
        return options;
      }
    ));
  }

  Future<UserResponse> getUser() async {
    try {
      Response response = await _dio.get(_endpoint);
      return UserResponse.fromJson(response.data);
    } catch (error, stacktrace) {
        print("Exception occured: $error stackTrace: $stacktrace response: ${error.response}");
        return null;
    }
  }
}