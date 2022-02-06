part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class OnShowManualMarkerEvent extends SearchEvent {}

class OnHideManualMarkerEvent extends SearchEvent {}
