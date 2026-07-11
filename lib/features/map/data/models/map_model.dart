import '../../domain/entities/map.dart';

class StoreLocationModel extends StoreLocationEntity {
  const StoreLocationModel({
    required super.id,
    required super.name,
    required super.address,
    required super.latitude,
    required super.longitude,
    required super.type,
    super.phone,
  });

  factory StoreLocationModel.fromMap(Map<String, dynamic> data, String id) {
    return StoreLocationModel(
      id: id,
      name: data['name'] ?? '',
      address: data['address'] ?? '',
      latitude: (data['latitude'] as num?)?.toDouble() ?? 0,
      longitude: (data['longitude'] as num?)?.toDouble() ?? 0,
      type: data['type'] ?? 'store',
      phone: data['phone'],
    );
  }
}
