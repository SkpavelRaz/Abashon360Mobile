import 'package:dio/dio.dart';

import 'data/validate_phone.dart';

class AuthService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://api.abashon360.com/api'));

  Future<ValidatePhoneData> validatePhone(String phone) async {
    final response = await _dio.get("cli/validate-pin-otp/$phone");

    return ValidatePhoneData.fromJson(response.data);
  }
}