import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/blocs/location/location_bloc.dart';
import 'package:location/blocs/map/map_bloc.dart';
import 'package:location/views/maps_view.dart';
import 'package:location/widgets/btn_current_location.dart';
import 'package:location/widgets/btn_follow_user.dart';
import 'package:location/widgets/btn_show_user_route.dart';
import 'package:location/widgets/manual_marker.dart';
import 'package:location/widgets/search_bar.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);
  static const routeName = '/MapPage';

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late LocationBloc locationBloc;
  @override
  void initState() {
    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.startFollowingUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, stateLocation) {
          if (stateLocation.lastKnownLocation == null) {
            return const Center(
              child: Text('Please wait...'),
            );
          }

          return BlocBuilder<MapBloc, MapState>(
            builder: (context, stateMap) {
              final polylines = Map<String, Polyline>.from(stateMap.polylines);
              if (!stateMap.showMyRoute) {
                polylines.removeWhere((key, value) => key == 'myWay');
              }
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    MapView(
                      initialLocation: stateLocation.lastKnownLocation!,
                      polylines: polylines.values.toSet(),
                      markers: stateMap.markers.values.toSet(),
                    ),
                    const SearchBar(),
                    const ManualMarker()
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          BtnShowUserRoute(),
          BtnCurrentLocation(),
          BtnFollowUser()
        ],
      ),
    );
  }

  @override
  void dispose() {
    locationBloc.stopFollowingUser();
    super.dispose();
  }
}
