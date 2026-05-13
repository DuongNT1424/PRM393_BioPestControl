import 'package:equatable/equatable.dart';

class WarehouseEntity extends Equatable {
  final int id;
  final String name;
  final String? address;

  const WarehouseEntity({
    required this.id,
    required this.name,
    this.address,
  });

  @override
  List<Object?> get props => [id, name, address];
}
