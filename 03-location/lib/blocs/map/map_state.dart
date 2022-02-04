part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool followUser;
  final bool mapInitialized;
  final bool showMyRoute;
  final Map<String, Polyline> polylines;
  const MapState({
    this.followUser = true,
    this.mapInitialized = false,
    this.polylines = const {},
    this.showMyRoute = true,
  });

  MapState copyWith({
    bool? followUser,
    bool? mapInitialized,
    bool? showMyRoute,
    Map<String, Polyline>? polylines,
  }) =>
      MapState(
          followUser: followUser ?? this.followUser,
          mapInitialized: mapInitialized ?? this.mapInitialized,
          polylines: polylines ?? this.polylines,
          showMyRoute: showMyRoute ?? this.showMyRoute);
  @override
  List<Object> get props =>
      [mapInitialized, followUser, polylines, showMyRoute];
}
