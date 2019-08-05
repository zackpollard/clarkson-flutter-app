import 'package:clarkson/http/utils.dart';
import 'package:clarkson/models/responses/fuel_response.dart';
import 'package:dio/dio.dart';

class FuelApiProvider {
  final String _endpoint = "https://clarkson.zackpollard.pro/api/vehicle/%vehicleId%/fuel";
  Dio _dio;

  FuelApiProvider() {
    _dio = Dio();
    _setupInterceptor();
  }

  void _setupInterceptor() {
    _dio.interceptors.add(Utils.getAuthenticationInterceptor(_dio));
  }

  Future<FuelResponse> getFuel(String vehicleId) async {
    try {
      String uri =_endpoint.replaceAll('%vehicleId%', vehicleId);
      print(uri);
      Response response = await _dio.get(uri);
      return FuelResponse.fromJson(response.data);
    } catch (error, stacktrace) {
        print("Exception occured: $error stackTrace: $stacktrace response: ${error.response}");
        return null;
    }
  }
}