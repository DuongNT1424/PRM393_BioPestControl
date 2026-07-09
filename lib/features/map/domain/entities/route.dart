import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

class RouteEntity extends Equatable {
  final double distanceMeters;
  final double durationSeconds;
  final List<LatLng> points;

  const RouteEntity({
    required this.distanceMeters,
    required this.durationSeconds,
    required this.points,
  });

  @override
  List<Object?> get props => [distanceMeters, durationSeconds, points];
}
