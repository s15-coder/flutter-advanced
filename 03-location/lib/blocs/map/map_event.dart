part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class OnMapInitialized extends MapEvent {
  final GoogleMapController googleMapController;
  const OnMapInitialized(this.googleMapController);
}

class OnStartFollowingUserEvent extends MapEvent {}

class OnStopFollowingUserEvent extends MapEvent {}

class UpdatePolylinesEvent extends MapEvent {
  final List<LatLng> locationsHistory;
  const UpdatePolylinesEvent(this.locationsHistory);
}

class OnToggleShowUserRouteEvent extends MapEvent {}
