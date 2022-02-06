import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteDestination {
  final double duration;
  final double distance;
  final List<LatLng> coords;

  RouteDestination({
    required this.duration,
    required this.distance,
    required this.coords,
  });
}
