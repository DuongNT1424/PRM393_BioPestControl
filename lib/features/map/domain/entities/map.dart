import 'package:equatable/equatable.dart';

class StoreLocationEntity extends Equatable {
  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String type;
  final String? phone;

  const StoreLocationEntity({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.type,
    this.phone,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        address,
        latitude,
        longitude,
        type,
        phone,
      ];
}
