import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/models/places_response.dart';
import 'package:location/models/route_destination.dart';
import 'package:location/services/mapbox_api/api_mapbox_service.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  late final TrafficService _trafficService;
  SearchBloc() : super(const SearchState()) {
    _trafficService = TrafficService();
    on<OnShowManualMarkerEvent>((_, emit) {
      emit(state.copyWith(showManualMarker: true));
    });
    on<OnHideManualMarkerEvent>((_, emit) {
      emit(state.copyWith(showManualMarker: false));
    });
    on<OnNewPlacesSuggestions>((event, emit) {
      emit(state.copyWith(places: event.places));
    });
    on<OnAddSearchEvent>((event, emit) {
      var historyTemp = [...state.history];
      historyTemp.removeWhere((place) => place.id == event.placeSearched.id);
      final newState =
          state.copyWith(history: [event.placeSearched, ...historyTemp]);
      emit(newState);
    });
  }

  Future<RouteDestination> getCoordsStartToEnd(LatLng start, LatLng end,
      {PlaceInfo? endPLaceInfoP}) async {
    PlaceInfo? placeInfo = endPLaceInfoP;
    //Get information about the place if manual marker is selected
    if (placeInfo == null) {
      final endInfo = await _trafficService.getPlaceInfoByCoords(end);
      placeInfo = PlaceInfo(
        placeName: endInfo.placeName,
        description: endInfo.text,
      );
    }

    final trafficResponse =
        await _trafficService.getCoordsStartToEnd(start, end);
    final distance = trafficResponse.routes[0].distance;
    final duration = trafficResponse.routes[0].duration;

    //Decode geometry of trafficResponse model
    final listCoords = decodePolyline(trafficResponse.routes[0].geometry);

    //Parse List<int> to LatLng
    final coords = listCoords
        .map((coordNumbers) =>
            LatLng(coordNumbers[0].toDouble(), coordNumbers[1].toDouble()))
        .toList();
    return RouteDestination(
      duration: duration,
      distance: distance,
      coords: coords,
      endPointInfo: placeInfo,
    );
  }

  Future getPlacesSuggestions(LatLng proximity, String query) async {
    final places = await _trafficService.getPlacesSuggestions(proximity, query);
    add(OnNewPlacesSuggestions(places));
  }
}
