
import 'package:abashon_360_mobile/modules/login/auth_service.dart';
import 'package:abashon_360_mobile/modules/login/data/validate_phone.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider= Provider((ref)=>AuthService());

final validatePhoneProvider=
    FutureProvider.family<ValidatePhoneData,String>((ref,phone) async{
      final service= ref.watch(authServiceProvider);
      return service.validatePhone(phone);
    });