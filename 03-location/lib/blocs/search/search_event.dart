part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class OnShowManualMarkerEvent extends SearchEvent {}

class OnHideManualMarkerEvent extends SearchEvent {}

class OnNewPlacesSuggestions extends SearchEvent {
  final List<Feature> places;

  const OnNewPlacesSuggestions(this.places);
}

class OnAddSearchEvent extends SearchEvent {
  final Feature placeSearched;
  const OnAddSearchEvent(this.placeSearched);
}
