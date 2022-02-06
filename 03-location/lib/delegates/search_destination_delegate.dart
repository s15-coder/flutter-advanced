import 'package:flutter/material.dart';
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
    return Container(
      child: Text('buildResults'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                Icon(Icons.location_on_outlined),
                SizedBox(width: 10),
                Text('Set market on the map',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.8),
                    )),
              ],
            ),
          ),
        )
      ],
    );
  }
}
