import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  StreamSubscription? _positionSubscription;
  LocationBloc() : super(const LocationState()) {
    on<OnStartFollowingUser>(
        (event, emit) => emit(state.copyWith(followingUser: true)));

    on<OnStopFollowingUser>(
        (event, emit) => emit(state.copyWith(followingUser: false)));

    on<AddUserLocationEvent>((event, emit) => emit(state.copyWith(
            followingUser: state.followingUser,
            lastKnownLocation: event.currentLocation,
            locationHistory: [
              ...state.locationHistory,
              event.currentLocation,
            ])));
  }
  Future getCurrentPosition() async {
    final currentPosition = await Geolocator.getCurrentPosition();
    print(currentPosition);
  }

  void startFollowingUser() {
    print("startFollowingUser");

    _positionSubscription =
        Geolocator.getPositionStream().listen((currentPosition) {
      add(AddUserLocationEvent(
        currentLocation: LatLng(
          currentPosition.latitude,
          currentPosition.longitude,
        ),
      ));
    });
  }

  void stopFollowingUser() {
    _positionSubscription?.cancel();
    print("stopFollowingUser");
  }

  @override
  Future<void> close() {
    stopFollowingUser();
    return super.close();
  }
}
