import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/blocs/location/location_bloc.dart';
import 'package:location/blocs/map/map_bloc.dart';
import 'package:location/blocs/search/search_bloc.dart';
import 'package:location/delegates/search_destination_delegate.dart';
import 'package:location/models/search_result.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.showManualMarker
            ? const SizedBox()
            : const _SearchBarBody();
      },
    );
  }
}

class _SearchBarBody extends StatelessWidget {
  const _SearchBarBody({Key? key}) : super(key: key);
  void onSeachResult(BuildContext context, SearchResult searchResult) async {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);
    if (searchResult.cancelled) return;
    if (searchResult.manualLocation) {
      final searchBloc = BlocProvider.of<SearchBloc>(context, listen: false);
      searchBloc.add(OnShowManualMarkerEvent());
    }
    if (searchResult.coords == null) return;
    if (locationBloc.state.lastKnownLocation == null) return;
    final start = locationBloc.state.lastKnownLocation!;
    final end = searchResult.coords!;
    final destination = await searchBloc.getCoordsStartToEnd(start, end);
    mapBloc.drawNewPolyline(destination);
    mapBloc.moveTo(start);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: FadeInDown(
        child: GestureDetector(
          onTap: () async {
            final result = await showSearch(
                context: context, delegate: SearchDestinationDelegate());
            if (result == null) return;
            onSeachResult(context, result);
          },
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 25),
            height: 50,
            width: double.infinity,
            margin: EdgeInsets.symmetric(
              horizontal: size.width * 0.1,
              vertical: 10,
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 10)
                ]),
            child: const Text(
              'Where you go?',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
