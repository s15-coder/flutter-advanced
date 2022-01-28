import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/blocs/gps/gps_bloc.dart';
import 'package:location/screens/access_location_page.dart';
import 'package:location/screens/map_page.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);
  static const routeName = '/LoadingPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GpsBloc, GpsState>(
        builder: (context, state) {
          return state.isAllLocationReady
              ? const MapPage()
              : const AccessLocationPage();
        },
      ),
    );
  }
}
