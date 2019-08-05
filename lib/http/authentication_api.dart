import '../models/requests/authenticate_request.dart';
import '../models/responses/authenticate_response.dart';
import 'package:dio/dio.dart';

class AuthenticateApiProvider {
  final String _endpoint = "https://clarkson.zackpollard.pro/api/auth/authenticate";
  final Dio _dio = Dio();

  Future<AuthenticateResponse> postAuthentication(AuthenticateRequest authenticationRequest) async {
    try {
      Response response = await _dio.post(_endpoint, data: authenticationRequest.toJson());
      return AuthenticateResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      if(error.response == null) {
        print("Exception occured: $error stackTrace: $stacktrace");
        return AuthenticateResponse(message: error, status: "Exception");
      }
      return AuthenticateResponse.fromJson(error.response.data);
    }
  }
}