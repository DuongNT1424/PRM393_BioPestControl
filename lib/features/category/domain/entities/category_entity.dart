import 'package:equatable/equatable.dart';

/// [CategoryEntity] đại diện cho một danh mục sản phẩm.
class CategoryEntity extends Equatable {
  final int id;
  final String name;
  final String? description;

  const CategoryEntity({
    required this.id,
    required this.name,
    this.description,
  });

  @override
  List<Object?> get props => [id, name, description];
}
