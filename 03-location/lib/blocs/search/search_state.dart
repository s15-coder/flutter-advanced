part of 'search_bloc.dart';

class SearchState extends Equatable {
  const SearchState(
      {this.showManualMarker = false,
      this.places = const [],
      this.history = const []});
  final bool showManualMarker;
  final List<Feature> places;
  final List<Feature> history;

  SearchState copyWith(
          {bool? showManualMarker,
          List<Feature>? places,
          List<Feature>? history}) =>
      SearchState(
        showManualMarker: showManualMarker ?? this.showManualMarker,
        places: places ?? this.places,
        history: history ?? this.history,
      );
  @override
  List<Object> get props => [showManualMarker, places, history];
}
