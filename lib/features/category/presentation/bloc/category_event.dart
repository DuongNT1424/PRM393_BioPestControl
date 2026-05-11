import 'package:equatable/equatable.dart';
import '../../domain/entities/category_entity.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object?> get props => [];
}

class LoadCategoriesEvent extends CategoryEvent {}

class AddCategoryEvent extends CategoryEvent {
  final CategoryEntity category;
  const AddCategoryEvent(this.category);
  @override
  List<Object?> get props => [category];
}

class UpdateCategoryEvent extends CategoryEvent {
  final CategoryEntity category;
  const UpdateCategoryEvent(this.category);
  @override
  List<Object?> get props => [category];
}

class DeleteCategoryEvent extends CategoryEvent {
  final int id;
  const DeleteCategoryEvent(this.id);
  @override
  List<Object?> get props => [id];
}
