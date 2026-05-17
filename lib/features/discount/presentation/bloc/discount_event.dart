import 'package:equatable/equatable.dart';
import '../../domain/entities/discount_entity.dart';

abstract class DiscountEvent extends Equatable {
  const DiscountEvent();
  @override
  List<Object?> get props => [];
}

class LoadDiscounts extends DiscountEvent {}

class SearchDiscounts extends DiscountEvent {
  final String query;
  const SearchDiscounts(this.query);
  @override
  List<Object?> get props => [query];
}

class FilterDiscounts extends DiscountEvent {
  final bool? isActive;
  const FilterDiscounts({this.isActive});
  @override
  List<Object?> get props => [isActive];
}

class AddDiscount extends DiscountEvent {
  final DiscountEntity discount;
  const AddDiscount(this.discount);
  @override
  List<Object?> get props => [discount];
}

class UpdateDiscount extends DiscountEvent {
  final DiscountEntity discount;
  const UpdateDiscount(this.discount);
  @override
  List<Object?> get props => [discount];
}

class DeleteDiscount extends DiscountEvent {
  final int id;
  const DeleteDiscount(this.id);
  @override
  List<Object?> get props => [id];
}
