import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tmdb_app/env.dart';
import 'package:tmdb_app/src/utils/dio/logger_intercepter.dart';

part 'dio_provider.g.dart';

@riverpod
Dio dio(DioRef ref) {
  final dio = Dio(BaseOptions(
    headers: {
      "Content-Type": "application/json",
      "Authorization": " Bearer ${Env.apiKey}",
    },
  ));
  dio.interceptors.add(LoggerInterceptor());
  return dio;
}
