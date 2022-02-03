part of 'location_bloc.dart';

class LocationState extends Equatable {
  const LocationState(
      {this.followingUser = false, this.lastKnownLocation, locationHistory})
      : locationHistory = locationHistory ?? const [];
  final bool followingUser;
  final LatLng? lastKnownLocation;
  final List<LatLng> locationHistory;

  LocationState copyWith({
    bool? followingUser,
    LatLng? lastKnownLocation,
    List<LatLng>? locationHistory,
  }) =>
      LocationState(
        lastKnownLocation: lastKnownLocation ?? this.lastKnownLocation,
        locationHistory: locationHistory ?? this.locationHistory,
        followingUser: followingUser ?? this.followingUser,
      );

  @override
  List<Object?> get props =>
      [followingUser, lastKnownLocation, locationHistory];
}
