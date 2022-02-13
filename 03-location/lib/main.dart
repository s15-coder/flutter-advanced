import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/blocs/gps/gps_bloc.dart';
import 'package:location/blocs/location/location_bloc.dart';
import 'package:location/blocs/map/map_bloc.dart';
import 'package:location/blocs/search/search_bloc.dart';
import 'package:location/helpers/markers/marker_widget_test.dart';
import 'package:location/screens/access_location_page.dart';
import 'package:location/screens/loading_page.dart';
import 'package:location/screens/map_page.dart';

void main() => runApp(const MyMaps());

class MyMaps extends StatelessWidget {
  const MyMaps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GpsBloc()),
        BlocProvider(create: (_) => LocationBloc()),
        BlocProvider(create: (_) => MapBloc(context: _)),
        BlocProvider(create: (_) => SearchBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyMaps',
        routes: {
          MapPage.routeName: (_) => const MapPage(),
          AccessLocationPage.routeName: (_) => const AccessLocationPage(),
          LoadingPage.routeName: (_) => const LoadingPage(),
        },
        initialRoute: LoadingPage.routeName,
        // home: MarkerWidget(),
      ),
    );
  }
}
