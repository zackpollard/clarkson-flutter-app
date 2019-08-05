import 'package:clarkson/http/utils.dart';
import 'package:clarkson/models/responses/vehicle_response.dart';
import 'package:dio/dio.dart';


class VehicleApiProvider {
  final String _endpoint = "https://clarkson.zackpollard.pro/api/vehicle";
  Dio _dio;

  VehicleApiProvider() {
    _dio = Dio();
    _setupInterceptor();
  }

  void _setupInterceptor() {
    _dio.interceptors.add(Utils.getAuthenticationInterceptor(_dio));
  }

  Future<VehicleResponse> getVehicle() async {
    try {
      Response response = await _dio.get(_endpoint);
      return VehicleResponse.fromJson(response.data);
    } catch (error, stacktrace) {
        print("Exception occured: $error stackTrace: $stacktrace response: ${error.response}");
        return null;
    }
  }
}