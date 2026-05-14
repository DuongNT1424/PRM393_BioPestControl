import 'package:equatable/equatable.dart';
import '../../domain/entities/customer_entity.dart';

abstract class CustomerEvent extends Equatable {
  const CustomerEvent();

  @override
  List<Object?> get props => [];
}

class LoadCustomers extends CustomerEvent {}

class SearchCustomers extends CustomerEvent {
  final String query;
  const SearchCustomers(this.query);

  @override
  List<Object?> get props => [query];
}

class FilterCustomers extends CustomerEvent {
  final bool? isLocked;
  const FilterCustomers({this.isLocked});

  @override
  List<Object?> get props => [isLocked];
}

class UpdateCustomer extends CustomerEvent {
  final CustomerEntity customer;
  const UpdateCustomer(this.customer);

  @override
  List<Object?> get props => [customer];
}

class ToggleCustomerLock extends CustomerEvent {
  final String id;
  final bool isLocked;
  const ToggleCustomerLock(this.id, this.isLocked);

  @override
  List<Object?> get props => [id, isLocked];
}

class GetCustomerDetail extends CustomerEvent {
  final String id;
  const GetCustomerDetail(this.id);

  @override
  List<Object?> get props => [id];
}
