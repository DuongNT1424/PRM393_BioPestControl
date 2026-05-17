import 'package:equatable/equatable.dart';
import '../../domain/entities/discount_entity.dart';

abstract class DiscountState extends Equatable {
  const DiscountState();
  @override
  List<Object?> get props => [];
}

class DiscountInitial extends DiscountState {}

class DiscountLoading extends DiscountState {}

class DiscountsLoaded extends DiscountState {
  final List<DiscountEntity> discounts;
  const DiscountsLoaded(this.discounts);
  @override
  List<Object?> get props => [discounts];
}

class DiscountOperationSuccess extends DiscountState {
  final String message;
  const DiscountOperationSuccess(this.message);
  @override
  List<Object?> get props => [message];
}

class DiscountError extends DiscountState {
  final String message;
  const DiscountError(this.message);
  @override
  List<Object?> get props => [message];
}
