import 'package:dio/dio.dart';
import 'package:location/global/enviroment_vabs.dart';

class DirectionsInterceptor extends Interceptor {
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
