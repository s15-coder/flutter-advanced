import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/models/places_response.dart';

class RouteDestination {
  final double duration;
  final double distance;
  final List<LatLng> coords;
  final PlaceInfo endPointInfo;

  RouteDestination({
    required this.duration,
    required this.distance,
    required this.coords,
    required this.endPointInfo,
  });
  RouteDestination copyWith(
          {double? duration,
          double? distance,
          List<LatLng>? coords,
          PlaceInfo? endPointInfo}) =>
      RouteDestination(
        duration: duration ?? this.duration,
        distance: distance ?? this.distance,
        coords: coords ?? this.coords,
        endPointInfo: endPointInfo ?? this.endPointInfo,
      );
}

class PlaceInfo {
  final String placeName;
  final String description;

  PlaceInfo({
    required this.placeName,
    required this.description,
  });
}
