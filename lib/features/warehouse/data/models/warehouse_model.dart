import 'package:prm393_biopestcontrol/features/warehouse/domain/entities/warehouse_entity.dart';

class WarehouseModel extends WarehouseEntity {
  const WarehouseModel({
    required super.id,
    required super.name,
    super.address,
  });

  factory WarehouseModel.fromMap(Map<String, dynamic> map) {
    return WarehouseModel(
      id: map['id'],
      name: map['name'],
      address: map['address'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
    };
  }
}
