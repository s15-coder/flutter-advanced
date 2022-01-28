part of 'gps_bloc.dart';

class GpsState extends Equatable {
  final bool isGpsEnabled;
  final bool isGpsPermissionGranted;
  const GpsState({
    required this.isGpsEnabled,
    required this.isGpsPermissionGranted,
  });
  bool get isAllLocationReady => isGpsEnabled && isGpsPermissionGranted;
  @override
  List<Object> get props => [isGpsPermissionGranted, isGpsEnabled];

  GpsState copyWith({
    bool? isGpsEnabled,
    bool? isGpsPermissionGranted,
  }) =>
      GpsState(
        isGpsEnabled: isGpsEnabled ?? this.isGpsEnabled,
        isGpsPermissionGranted:
            isGpsPermissionGranted ?? this.isGpsPermissionGranted,
      );
  @override
  String toString() =>
      'State: {isGpsEnabled:$isGpsEnabled, isGpsPermissionGranted:$isGpsPermissionGranted}';
}
