import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/blocs/location/location_bloc.dart';
import 'package:location/blocs/map/map_bloc.dart';
import 'package:location/blocs/search/search_bloc.dart';
import 'package:location/models/search_result.dart';

class SearchDestinationDelegate extends SearchDelegate<SearchResult> {
  SearchDestinationDelegate() : super(searchFieldLabel: 'Search destination');
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = "",
        icon: const Icon(Icons.close),
      )
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      textTheme: const TextTheme(headline6: TextStyle(color: Colors.white)),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white),
        border: InputBorder.none,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.purple,
      ),
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        final searchResult = SearchResult(cancelled: true);
        close(context, searchResult);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final proximity = locationBloc.state.lastKnownLocation;
    searchBloc.getPlacesSuggestions(proximity!, query);
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (_, i) {
            final place = state.places[i];
            return ListTile(
              onTap: () {
                final searchResult = SearchResult(
                  cancelled: false,
                  manualLocation: false,
                  coords: LatLng(
                    place.center[1],
                    place.center[0],
                  ),
                  name: place.text,
                  description: place.placeName,
                );
                searchBloc.add(OnAddSearchEvent(place));
                close(context, searchResult);
              },
              title: Text(place.text),
              subtitle: Text(place.placeName),
              leading: const CircleAvatar(
                child: Icon(
                  Icons.place_outlined,
                  color: Colors.white,
                ),
                backgroundColor: Colors.purple,
              ),
            );
          },
          separatorBuilder: (_, i) => const Divider(),
          itemCount: state.places.length,
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final searchBloc = BlocProvider.of<SearchBloc>(context);

    return ListView(
      children: [
        InkWell(
          onTap: () {
            final searchResult =
                SearchResult(cancelled: false, manualLocation: true);
            close(context, searchResult);
          },
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: size.width * 0.05, vertical: 10),
            child: Row(
              children: [
                const Icon(Icons.location_on_outlined),
                const SizedBox(width: 10),
                Text('Set market on the map',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.8),
                    )),
              ],
            ),
          ),
        ),
        ...searchBloc.state.history.map((place) {
          return ListTile(
            onTap: () {
              final searchResult = SearchResult(
                cancelled: false,
                manualLocation: false,
                coords: LatLng(
                  place.center[1],
                  place.center[0],
                ),
                name: place.text,
                description: place.placeName,
              );
              searchBloc.add(OnAddSearchEvent(place));

              close(context, searchResult);
            },
            title: Text(place.text),
            subtitle: Text(place.placeName),
            leading: const CircleAvatar(
              child: Icon(
                Icons.place_outlined,
                color: Colors.white,
              ),
              backgroundColor: Colors.purple,
            ),
          );
        }).toList()
      ],
    );
  }
}
