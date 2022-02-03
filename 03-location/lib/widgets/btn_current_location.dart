import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/blocs/location/location_bloc.dart';
import 'package:location/blocs/map/map_bloc.dart';
import 'package:location/ui/custom_snackbar.dart';

class BtnCurrentLocation extends StatelessWidget {
  const BtnCurrentLocation({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);
    return FloatingActionButton(
      onPressed: () {
        final currentLocation = locationBloc.state.lastKnownLocation;
        final snackBar = CustomSnackbar(label: 'There is not location');
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        if (currentLocation == null) return;
        mapBloc.moveTo(currentLocation);
      },
      child: const Icon(Icons.center_focus_strong),
    );
  }
}
