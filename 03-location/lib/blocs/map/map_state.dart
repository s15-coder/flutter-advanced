part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool followUser;
  final bool mapInitialized;
  final bool showMyRoute;
  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers;
  const MapState({
    this.followUser = true,
    this.mapInitialized = false,
    this.polylines = const {},
    this.markers = const {},
    this.showMyRoute = true,
  });

  MapState copyWith({
    bool? followUser,
    bool? mapInitialized,
    bool? showMyRoute,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
  }) =>
      MapState(
        followUser: followUser ?? this.followUser,
        mapInitialized: mapInitialized ?? this.mapInitialized,
        polylines: polylines ?? this.polylines,
        showMyRoute: showMyRoute ?? this.showMyRoute,
        markers: markers ?? this.markers,
      );
  @override
  List<Object> get props => [
        mapInitialized,
        followUser,
        polylines,
        showMyRoute,
        markers,
      ];
}
