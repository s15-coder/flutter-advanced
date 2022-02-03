part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool followUser;
  final bool mapInitialized;
  const MapState({
    this.followUser = false,
    this.mapInitialized = false,
  });

  MapState copyWith({
    bool? followUser,
    bool? mapInitialized,
  }) =>
      MapState(
        followUser: followUser ?? this.followUser,
        mapInitialized: mapInitialized ?? this.mapInitialized,
      );
  @override
  List<Object> get props => [mapInitialized, followUser];
}
