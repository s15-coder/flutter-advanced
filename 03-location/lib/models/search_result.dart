import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchResult {
  final bool manualLocation;
  final bool cancelled;
  final String? name;
  final String? description;
  final LatLng? coords;
  SearchResult({
    this.manualLocation = false,
    required this.cancelled,
    this.coords,
    this.description,
    this.name,
  });
}
