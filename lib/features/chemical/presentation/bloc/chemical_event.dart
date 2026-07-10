import 'package:equatable/equatable.dart';
import '../../domain/entities/chemical_entity.dart';

abstract class ChemicalEvent extends Equatable {
  const ChemicalEvent();

  @override
  List<Object?> get props => [];
}

class LoadChemicalsEvent extends ChemicalEvent {}

class SearchChemicalsEvent extends ChemicalEvent {
  final String query;
  const SearchChemicalsEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class FilterChemicalsEvent extends ChemicalEvent {
  final String? signalWord;
  final bool? isBanned;
  const FilterChemicalsEvent({this.signalWord, this.isBanned});

  @override
  List<Object?> get props => [signalWord, isBanned];
}

class CreateChemicalEvent extends ChemicalEvent {
  final ChemicalEntity chemical;
  const CreateChemicalEvent(this.chemical);

  @override
  List<Object?> get props => [chemical];
}

class UpdateChemicalEvent extends ChemicalEvent {
  final ChemicalEntity chemical;
  const UpdateChemicalEvent(this.chemical);

  @override
  List<Object?> get props => [chemical];
}

class DeleteChemicalEvent extends ChemicalEvent {
  final String id;
  const DeleteChemicalEvent(this.id);

  @override
  List<Object?> get props => [id];
}
