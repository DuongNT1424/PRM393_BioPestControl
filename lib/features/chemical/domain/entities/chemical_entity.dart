import 'package:equatable/equatable.dart';

class ChemicalEntity extends Equatable {
  final String? id;
  final String commonName;
  final String? casNumber;
  final String? signalWord;
  final String? hazardStatement;
  final String? precautionaryStatement;
  final String? firstAidMeasures;
  final String? hazardSymbol;
  final bool isBanned;
  final String? createdById;
  final String? createdByName;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ChemicalEntity({
    this.id,
    required this.commonName,
    this.casNumber,
    this.signalWord,
    this.hazardStatement,
    this.precautionaryStatement,
    this.firstAidMeasures,
    this.hazardSymbol,
    this.isBanned = false,
    this.createdById,
    this.createdByName,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        commonName,
        casNumber,
        signalWord,
        hazardStatement,
        precautionaryStatement,
        firstAidMeasures,
        hazardSymbol,
        isBanned,
        createdById,
        createdByName,
        createdAt,
        updatedAt,
      ];
}
