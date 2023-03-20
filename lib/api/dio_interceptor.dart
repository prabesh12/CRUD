import 'package:dio/dio.dart';
class DioInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // Crash reporting
    if (err.response != null) handler.resolve(err.response!);
  }
}
