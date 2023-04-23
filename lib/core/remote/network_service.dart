import 'package:dio/dio.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:ecomm_app/core/env/env_reader.dart';
import 'package:ecomm_app/core/remote/network_service_interceptor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final networkServiceProvider = Provider<Dio>((ref) {
  final envReader = ref.watch(envReaderProvider);
  final options = BaseOptions(
    baseUrl: envReader.getBaseUrl(),
    connectTimeout: const Duration(milliseconds: 60),
    sendTimeout: const Duration(milliseconds: 60),
    receiveTimeout: const Duration(milliseconds: 60),
  );

  final _dio = Dio(options)
    ..interceptors.addAll([
      HttpFormatter(),
      NetworkServiceInterceptor(),
    ]);
  return _dio;
});
