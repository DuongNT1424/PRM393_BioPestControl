import 'package:equatable/equatable.dart';
import '../../domain/entities/chemical_entity.dart';

abstract class ChemicalState extends Equatable {
  const ChemicalState();

  @override
  List<Object?> get props => [];
}

class ChemicalInitial extends ChemicalState {}

class ChemicalLoading extends ChemicalState {}

class ChemicalLoaded extends ChemicalState {
  final List<ChemicalEntity> chemicals;
  const ChemicalLoaded(this.chemicals);

  @override
  List<Object?> get props => [chemicals];
}

class ChemicalActionSuccess extends ChemicalState {
  final String message;
  const ChemicalActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class ChemicalError extends ChemicalState {
  final String message;
  const ChemicalError(this.message);

  @override
  List<Object?> get props => [message];
}
