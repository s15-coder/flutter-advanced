import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/blocs/map/map_bloc.dart';

class MapView extends StatelessWidget {
  const MapView({
    Key? key,
    required this.initialLocation,
    required this.polylines,
    required this.markers,
  }) : super(key: key);
  final LatLng initialLocation;
  final Set<Polyline> polylines;
  final Set<Marker> markers;
  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final initialCameraPosition = CameraPosition(
      target: initialLocation,
      zoom: 14.4746,
    );
    final size = MediaQuery.of(context).size;
    return SizedBox(
        height: size.height,
        width: size.width,
        child: Listener(
          onPointerHover: (_) =>
              BlocProvider.of<MapBloc>(context).add(OnStopFollowingUserEvent()),
          child: GoogleMap(
            polylines: polylines,
            markers: markers,
            zoomControlsEnabled: false,
            initialCameraPosition: initialCameraPosition,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            compassEnabled: false,
            onMapCreated: (controller) => mapBloc.add(
              OnMapInitialized(controller),
            ),
            onCameraMove: (cameraPosition) =>
                mapBloc.mapCenter = cameraPosition.target,
          ),
        ));
  }
}
