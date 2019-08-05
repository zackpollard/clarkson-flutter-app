import 'package:clarkson/http/utils.dart';
import 'package:clarkson/models/responses/dashboard_response.dart';
import 'package:dio/dio.dart';


class DashboardApiProvider {
  final String _endpoint = "https://clarkson.zackpollard.pro/api/dashboard";
  Dio _dio;

  DashboardApiProvider() {
    _dio = Dio();
    _setupInterceptor();
  }

  void _setupInterceptor() {
    _dio.interceptors.add(Utils.getAuthenticationInterceptor(_dio));
  }

  Future<DashboardResponse> getDashboard() async {
    try {
      Response response = await _dio.get(_endpoint);
      return DashboardResponse.fromJson(response.data);
    } catch (error, stacktrace) {
        print("Exception occured: $error stackTrace: $stacktrace response: ${error.response}");
        return null;
    }
  }
}