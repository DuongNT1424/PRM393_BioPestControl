import 'package:equatable/equatable.dart';

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
