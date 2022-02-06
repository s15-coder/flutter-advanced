import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:location/models/traffic_response.dart';
import 'package:location/services/traffic_interceptor.dart';

class TrafficService {
  late final Dio _trafficDio;
  final String _baseTrafficUrl = 'https://api.mapbox.com/directions/v5/mapbox';
  TrafficService() {
    _trafficDio = Dio();
    _trafficDio.interceptors.add(TrafficInterceptor());
  }

  Future<TrafficResponse> getCoordsStartToEnd(LatLng start, LatLng end) async {
    final coordsString =
        '${start.longitude},${start.latitude};${end.longitude},${end.latitude}';
    final url = '$_baseTrafficUrl/driving/$coordsString';
    final resp = await _trafficDio.get(url);
    final trafficResponse = TrafficResponse.fromJson(resp.data);
    return trafficResponse;
  }
}
