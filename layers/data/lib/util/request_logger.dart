import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class RequestLogger extends Interceptor {
  RequestLogger({Logger? logger}) : logger = logger ?? Logger();

  final Logger logger;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.v(
      'REQUEST[${options.method}] => PATH: ${options.path}',
    );

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.v(
      'RESPONSE[${response.statusCode}] => '
      'PATH: ${response.requestOptions.path}',
    );
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    logger.v(
      'ERROR[${err.response?.statusCode}] => '
      'PATH: ${err.requestOptions.path}',
    );

    return super.onError(err, handler);
  }
}
