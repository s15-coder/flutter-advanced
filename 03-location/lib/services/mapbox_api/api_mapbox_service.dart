import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:location/models/directions_response.dart';
import 'package:location/models/places_response.dart';
import 'package:location/services/mapbox_api/interceptors/directions_interceptor.dart';
import 'package:location/services/mapbox_api/interceptors/places_interceptor.dart';

class TrafficService {
  late final Dio _directionsDio;
  late final Dio _placesDio;
  final String _baseDirectionsUrl =
      'https://api.mapbox.com/directions/v5/mapbox';
  final String _basePlacessUrl =
      'https://api.mapbox.com/geocoding/v5/mapbox.places';
  TrafficService() {
    _directionsDio = Dio();
    _directionsDio.interceptors.add(DirectionsInterceptor());
    _placesDio = Dio();
    _placesDio.interceptors.add(PlacesInterceptor());
  }

  Future<DirectionsResponse> getCoordsStartToEnd(
      LatLng start, LatLng end) async {
    final coordsString =
        '${start.longitude},${start.latitude};${end.longitude},${end.latitude}';
    final url = '$_baseDirectionsUrl/driving/$coordsString';
    final resp = await _directionsDio.get(url);
    final trafficResponse = DirectionsResponse.fromJson(resp.data);
    return trafficResponse;
  }

  Future<List<Feature>> getPlacesSuggestions(
      LatLng proximity, String query) async {
    if (query.isEmpty) return [];
    final url = '$_basePlacessUrl/$query.json';
    final resp = await _directionsDio.get(url, queryParameters: {
      "proximity": '${proximity.longitude},${proximity.latitude}'
    });
    final placesResponse = placesResponseFromJson(resp.data);
    return placesResponse.features;
  }
}
