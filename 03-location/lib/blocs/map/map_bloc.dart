import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/blocs/location/location_bloc.dart';
import 'package:location/helpers/marker_from_image.dart';
import 'package:location/helpers/painter_marker.dart';
import 'package:location/models/route_destination.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  late LocationBloc locationBloc;
  GoogleMapController? _googleMapController;
  StreamSubscription<LocationState>? locationStream;
  LatLng? mapCenter;

  MapBloc({required BuildContext context}) : super(const MapState()) {
    locationBloc = BlocProvider.of<LocationBloc>(context);
    on<OnMapInitialized>(_initMap);

    on<OnStartFollowingUserEvent>(_onStartFollowingUser);

    on<OnStopFollowingUserEvent>(
        (event, emit) => emit(state.copyWith(followUser: false)));

    on<OnToggleShowUserRouteEvent>(
        (event, emit) => emit(state.copyWith(showMyRoute: !state.showMyRoute)));

    on<UpdatePolylinesEvent>(_onUpdatePolylines);

    on<OnAddNewPolyline>((event, emit) => emit(state.copyWith(
          polylines: event.polylines,
          markers: event.marker,
        )));

    locationStream = locationBloc.stream.listen((locationState) {
      if (locationState.lastKnownLocation == null) return;

      add(UpdatePolylinesEvent(locationState.locationHistory));

      if (!state.followUser) return;

      moveTo(locationState.lastKnownLocation!);
    });
  }
  void _onUpdatePolylines(UpdatePolylinesEvent event, Emitter<MapState> emit) {
    final polyline = Polyline(
      polylineId: const PolylineId('myWay'),
      color: Colors.black,
      points: event.locationsHistory,
      width: 4,
      endCap: Cap.roundCap,
      startCap: Cap.roundCap,
    );
    final newPolylines = Map<String, Polyline>.from(state.polylines);
    newPolylines['myWay'] = polyline;
    emit(state.copyWith(polylines: newPolylines));
  }

  void _initMap(OnMapInitialized event, Emitter<MapState> emit) {
    _googleMapController = event.googleMapController;
    // _googleMapController?.setMapStyle(json.encode(ultraLigtMapTheme));
    emit(state.copyWith(mapInitialized: true));
  }

  void _onStartFollowingUser(
      OnStartFollowingUserEvent event, Emitter<MapState> emit) {
    emit(state.copyWith(followUser: true));
    if (locationBloc.state.lastKnownLocation == null) return;
    moveTo(locationBloc.state.lastKnownLocation!);
  }

  Future drawNewPolyline(RouteDestination routeDestination) async {
    final polyline = Polyline(
        polylineId: const PolylineId('destination'),
        points: routeDestination.coords,
        color: Colors.black,
        endCap: Cap.roundCap,
        startCap: Cap.roundCap,
        width: 3);
    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines['destination'] = polyline;

    final kms = (routeDestination.distance / 1000)
        .toStringAsFixed(1)
        .replaceAll('.0', '');
    final duration = (routeDestination.duration / 60).floor();
    final placeNameEnd = routeDestination.endPointInfo.placeName;

    // final markerStartIcon = await getMarkerFromImage();
    // final markerEndIcon = await getMarkerFromNetwordImage();
    final markerStartIcon = await getStartMarkerPainter(
      duration.toString(),
      'My location',
    );
    final markerEndIcon =
        await getEndMarkerPainter(kms.toString(), placeNameEnd);

    final startMarker = Marker(
      markerId: const MarkerId('start'),
      position: routeDestination.coords.first,
      icon: markerStartIcon,
      anchor: const Offset(0, 1.0),

      // infoWindow: InfoWindow(
      //   title: 'Start point',
      //   snippet: 'Kms: $kms, Duration: $duration',
      // ),
    );
    final endMarker = Marker(
      markerId: const MarkerId('end'),
      position: routeDestination.coords.last,
      icon: markerEndIcon,
      anchor: const Offset(0, 1.0),

      // infoWindow: InfoWindow(
      //   title: routeDestination.endPointInfo.placeName,
      //   snippet: routeDestination.endPointInfo.description,
      // ),
    );

    final currentMarkers = Map<String, Marker>.from(state.markers);
    currentMarkers['start'] = startMarker;
    currentMarkers['end'] = endMarker;
    add(OnAddNewPolyline(currentPolylines, currentMarkers));
    await Future.delayed(const Duration(milliseconds: 300));
    _googleMapController?.showMarkerInfoWindow(const MarkerId('start'));
  }

  void moveTo(LatLng coords) {
    final cameraUpdate = CameraUpdate.newLatLng(coords);
    _googleMapController?.animateCamera(cameraUpdate);
  }

  @override
  Future<void> close() {
    locationStream?.cancel();
    return super.close();
  }
}
