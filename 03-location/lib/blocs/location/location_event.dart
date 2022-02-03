part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class AddUserLocationEvent extends LocationEvent {
  final LatLng currentLocation;
  const AddUserLocationEvent({
    required this.currentLocation,
  });
}

class OnStartFollowingUser extends LocationEvent {}

class OnStopFollowingUser extends LocationEvent {}
