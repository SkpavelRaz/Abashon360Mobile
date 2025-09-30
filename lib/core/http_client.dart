import 'dart:developer';
import 'package:dio/dio.dart';
import 'env.dart';

//
// Dio createDio() {
//   final options = BaseOptions(
//     baseUrl: Env.baseUrl,
//     connectTimeout: const Duration(seconds: 20),
//     receiveTimeout: const Duration(seconds: 20),
//     sendTimeout: const Duration(seconds: 20),
//     headers: {
//       'Accept': 'application/json',
//       'Content-Type': 'application/json; charset=utf-8',
//     },
//   );
//   final dio = Dio(options);
//
//
//   dio.interceptors.add(
//     InterceptorsWrapper(
//       onRequest: (options, handler) {
//         log('[HTTP] → ${options.method} ${options.uri}');
//         if (options.data != null) {
//           log('[HTTP] body → ${options.data}');
//         }
//         return handler.next(options);
//       },
//       onResponse: (res, handler) {
//         log('[HTTP] ← ${res.statusCode} ${res.requestOptions.uri}');
//         return handler.next(res);
//       },
//       onError: (err, handler) {
//         log('[HTTP][ERR] ${err.message} @ ${err.requestOptions.uri}');
//         return handler.next(err);
//       },
//     ),
//   );
//
//
//   return dio;
// }