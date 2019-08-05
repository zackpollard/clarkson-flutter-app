import 'package:clarkson/models/requests/authenticate_request.dart';
import 'package:clarkson/models/responses/authenticate_response.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'authentication_api.dart';

class Utils {
  static InterceptorsWrapper getAuthenticationInterceptor(Dio _dio) {
    return InterceptorsWrapper(
        onRequest: (RequestOptions options) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          options.headers["Authorization"] =
          "JWT ${prefs.getString("access_token")}";
          print("Auth: ${options.headers["Authorization"]}");
          return options;
        },
        onError: (DioError error) async {
          if(error.response?.statusCode == 401) {
            _dio.lock();
            _dio.interceptors.responseLock.lock();
            _dio.interceptors.errorLock.lock();

            final prefs = await SharedPreferences.getInstance();
            final username = prefs.getString("username");
            final password = prefs.getString("password");

            final AuthenticateApiProvider _authenticateApiProvider = AuthenticateApiProvider();

            AuthenticateResponse response = await _authenticateApiProvider
                .postAuthentication(
                AuthenticateRequest(
                    username: username,
                    password: password
                )
            );

            print("Re-Authenticated Auth - JWT: ${response.token}");
            prefs.setString("access_token", response.token);

            _dio.unlock();
            _dio.interceptors.responseLock.unlock();
            _dio.interceptors.errorLock.unlock();
            return _dio.request(error.response.request.path, options: error.response.request);
          }
          return error;
        }
    );
  }
}