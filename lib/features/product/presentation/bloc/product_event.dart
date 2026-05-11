import 'package:equatable/equatable.dart';
import '../../domain/entities/product_entity.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class LoadProductsEvent extends ProductEvent {}

class SearchProductEvent extends ProductEvent {
  final String query;
  const SearchProductEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class FilterProductEvent extends ProductEvent {
  final int? categoryId;
  final bool? isActive;
  const FilterProductEvent({this.categoryId, this.isActive});

  @override
  List<Object?> get props => [categoryId, isActive];
}

class AddProductEvent extends ProductEvent {
  final ProductEntity product;
  const AddProductEvent(this.product);

  @override
  List<Object?> get props => [product];
}

class UpdateProductEvent extends ProductEvent {
  final ProductEntity product;
  const UpdateProductEvent(this.product);

  @override
  List<Object?> get props => [product];
}

class DeleteProductEvent extends ProductEvent {
  final int id;
  const DeleteProductEvent(this.id);

  @override
  List<Object?> get props => [id];
}
