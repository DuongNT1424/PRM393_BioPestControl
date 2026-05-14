import 'package:equatable/equatable.dart';
import '../../domain/entities/staff_entity.dart';

abstract class StaffEvent extends Equatable {
  const StaffEvent();

  @override
  List<Object?> get props => [];
}

class LoadStaffsEvent extends StaffEvent {}

class AddStaffEvent extends StaffEvent {
  final StaffEntity staff;
  const AddStaffEvent(this.staff);

  @override
  List<Object?> get props => [staff];
}

class UpdateStaffEvent extends StaffEvent {
  final StaffEntity staff;
  const UpdateStaffEvent(this.staff);

  @override
  List<Object?> get props => [staff];
}

class DeleteStaffEvent extends StaffEvent {
  final String id;
  const DeleteStaffEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class SearchStaffsEvent extends StaffEvent {
  final String query;
  const SearchStaffsEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class SendPasswordResetEvent extends StaffEvent {
  final String email;
  const SendPasswordResetEvent(this.email);

  @override
  List<Object?> get props => [email];
}
