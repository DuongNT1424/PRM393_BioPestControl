import 'package:equatable/equatable.dart';

class PlaceEntity extends Equatable {
  final String displayName;
  final double latitude;
  final double longitude;

  const PlaceEntity({
    required this.displayName,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [displayName, latitude, longitude];
}
