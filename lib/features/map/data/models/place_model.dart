import '../../domain/entities/place.dart';

class PlaceModel extends PlaceEntity {
  const PlaceModel({
    required super.displayName,
    required super.latitude,
    required super.longitude,
  });

  factory PlaceModel.fromNominatim(Map<String, dynamic> json) {
    return PlaceModel(
      displayName: json['display_name'] ?? '',
      latitude: double.tryParse(json['lat'] ?? '') ?? 0,
      longitude: double.tryParse(json['lon'] ?? '') ?? 0,
    );
  }
}
