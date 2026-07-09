import 'package:latlong2/latlong.dart';
import '../../domain/entities/route.dart';

class RouteModel extends RouteEntity {
  const RouteModel({
    required super.distanceMeters,
    required super.durationSeconds,
    required super.points,
  });

  factory RouteModel.fromOsrm(Map<String, dynamic> json) {
    final route = json['routes'][0];
    final coordinates = route['geometry']['coordinates'] as List;
    return RouteModel(
      distanceMeters: (route['distance'] as num).toDouble(),
      durationSeconds: (route['duration'] as num).toDouble(),
      points: coordinates
          .map((point) => LatLng(
                (point[1] as num).toDouble(),
                (point[0] as num).toDouble(),
              ))
          .toList(),
    );
  }
}
