import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/themes/themes.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  GoogleMapController? _googleMapController;
  MapBloc() : super(const MapState()) {
    on<OnMapInitialized>(_initMap);
  }

  void _initMap(OnMapInitialized event, Emitter<MapState> emit) {
    _googleMapController = event.googleMapController;
    _googleMapController?.setMapStyle(json.encode(ultraLigtMapTheme));
    emit(state.copyWith(mapInitialized: true));
  }

  void moveTo(LatLng coords) {
    final cameraUpdate = CameraUpdate.newLatLng(coords);
    _googleMapController!.animateCamera(cameraUpdate);
  }
}
