import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/chemical_entity.dart';

class ChemicalModel extends ChemicalEntity {
  const ChemicalModel({
    super.id,
    required super.commonName,
    super.casNumber,
    super.signalWord,
    super.hazardStatement,
    super.precautionaryStatement,
    super.firstAidMeasures,
    super.hazardSymbol,
    super.isBanned,
    super.createdById,
    super.createdByName,
    super.createdAt,
    super.updatedAt,
  });

  factory ChemicalModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChemicalModel.fromMap(data, doc.id);
  }

  factory ChemicalModel.fromMap(Map<String, dynamic> data, String id) {
    return ChemicalModel(
      id: id,
      commonName: data['commonName'] ?? '',
      casNumber: data['casNumber'],
      signalWord: data['signalWord'],
      hazardStatement: data['hazardStatement'],
      precautionaryStatement: data['precautionaryStatement'],
      firstAidMeasures: data['firstAidMeasures'],
      hazardSymbol: data['hazardSymbol'],
      isBanned: data['isBanned'] ?? false,
      createdById: data['createdById'],
      createdByName: data['createdByName'],
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'commonName': commonName,
      'casNumber': casNumber,
      'signalWord': signalWord,
      'hazardStatement': hazardStatement,
      'precautionaryStatement': precautionaryStatement,
      'firstAidMeasures': firstAidMeasures,
      'hazardSymbol': hazardSymbol,
      'isBanned': isBanned,
      'createdById': createdById,
      'createdByName': createdByName,
      'createdAt': createdAt != null
          ? Timestamp.fromDate(createdAt!)
          : FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
