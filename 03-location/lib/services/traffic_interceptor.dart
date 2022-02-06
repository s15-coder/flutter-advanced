import 'package:dio/dio.dart';

const accessToken =
    'pk.eyJ1Ijoic2VyZ2lvMWVzdGViYW4iLCJhIjoiY2t6OTd0Z2FxMGhsYjMwcDRhNTd1eWMxZiJ9.6CiPrF4mZ_5AZAZx8L6dtg';

class TrafficInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'alternatives': 'true',
      'geometries': 'polyline',
      'overview': 'simplified',
      'steps': 'false',
      'access_token': accessToken,
    });
    super.onRequest(options, handler);
  }
}
