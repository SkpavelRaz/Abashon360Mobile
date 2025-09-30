import 'package:dio/dio.dart';

import 'data/validate_phone.dart';

class AuthService {
  late final Dio _dio;

  AuthService() {
    _dio = Dio(BaseOptions(
        baseUrl: 'https://api.abashon360.com/api',
        headers: {
          'authtoken': "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdXRob3JfbmFtZSI6ImFiYXNob24tYWRtaW4iLCJhY19rZXkiOiJhcmdvbjJpZHYxOW02NTUzNnQzcDRoakNhc0NTQ0tSVXJyWkZxUUltekFXM1BGeThrU2lhelE2UW9BRmkySEMzd21KbnRia3E0aXlGUlVWYXM3WTQiLCJpYXQiOjE3NTkyMTU5OTN9.C4sPos5_vF4v8wTKRyeMKOBZzLOpM2VzIsJCrJcGFhs",
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }
    ));

    // ✅ Optional: Add Interceptor for debugging or retry logic
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print('➡️ Request: ${options.method} ${options.path}');
        print('Headers: ${options.headers}');
        print('Data: ${options.data}');
        return handler.next(options);
      },
      onError: (DioException e, handler) {
        print('❌ API Error: ${e.response?.statusCode} - ${e.response?.data}');
        return handler.next(e);
      },
    ));
  }

  Future<ValidatePhoneData> validatePhone(String phone) async {
    final response = await _dio.get("/cli/validate-pin-otp/$phone");
    return ValidatePhoneData.fromJson(response.data);
  }
}
