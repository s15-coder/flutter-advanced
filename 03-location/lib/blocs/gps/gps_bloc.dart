import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  GpsBloc()
      : super(const GpsState(
          isGpsPermissionGranted: false,
          isGpsEnabled: false,
        )) {
    on<GpsAndPermissionEvent>((event, emit) => emit(state.copyWith(
        isGpsEnabled: event.isGpsEnabled,
        isGpsPermissionGranted: event.isGpsPermissionGranted)));
    _init();
  }

  void _init() async {
    final _gpsInitStatus = await Future.wait([
      _checkGpsStatus(),
      _checkGpsPermissions(),
    ]);
    add(GpsAndPermissionEvent(
      isGpsEnabled: _gpsInitStatus[0],
      isGpsPermissionGranted: _gpsInitStatus[1],
    ));
  }

  Future<bool> _checkGpsPermissions() async =>
      await Permission.location.isGranted;

  Future<bool> _checkGpsStatus() async {
    Geolocator.getServiceStatusStream().listen((event) {
      final isEnabled = event.index == 1;

      add(GpsAndPermissionEvent(
        isGpsEnabled: isEnabled,
        isGpsPermissionGranted: state.isGpsPermissionGranted,
      ));
    });

    return await Geolocator.isLocationServiceEnabled();
  }

  Future<void> requestGpsAccess() async {
    await Permission.location.request();
    if (await Permission.location.isGranted) {
      add(GpsAndPermissionEvent(
          isGpsPermissionGranted: true, isGpsEnabled: state.isGpsEnabled));
    } else {
      add(GpsAndPermissionEvent(
        isGpsPermissionGranted: false,
        isGpsEnabled: state.isGpsEnabled,
      ));
      openAppSettings();
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
