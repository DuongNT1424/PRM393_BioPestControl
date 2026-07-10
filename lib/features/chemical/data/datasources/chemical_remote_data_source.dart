import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/chemical_model.dart';

abstract class ChemicalRemoteDataSource {
  Future<List<ChemicalModel>> getChemicals();
  Future<ChemicalModel> getChemicalById(String id);
  Future<List<ChemicalModel>> searchChemicals(String query);
  Future<List<ChemicalModel>> filterChemicals({
    String? signalWord,
    bool? isBanned,
  });
  Future<void> createChemical(ChemicalModel chemical);
  Future<void> updateChemical(ChemicalModel chemical);
  Future<void> deleteChemical(String id);
}

class ChemicalRemoteDataSourceImpl implements ChemicalRemoteDataSource {
  final FirebaseFirestore firestore;

  static const String _collection = 'chemicals';

  ChemicalRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<ChemicalModel>> getChemicals() async {
    final snapshot = await firestore
        .collection(_collection)
        .orderBy('commonName')
        .get();
    return snapshot.docs
        .map((doc) => ChemicalModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  @override
  Future<ChemicalModel> getChemicalById(String id) async {
    final doc = await firestore.collection(_collection).doc(id).get();
    if (!doc.exists) {
      throw Exception('Không tìm thấy hóa chất với ID: $id');
    }
    return ChemicalModel.fromFirestore(doc);
  }

  @override
  Future<List<ChemicalModel>> searchChemicals(String query) async {
    final snapshot = await firestore
        .collection(_collection)
        .orderBy('commonName')
        .get();
    final lowerQuery = query.toLowerCase();
    return snapshot.docs
        .map((doc) => ChemicalModel.fromMap(doc.data(), doc.id))
        .where((chemical) =>
            chemical.commonName.toLowerCase().contains(lowerQuery) ||
            (chemical.casNumber?.toLowerCase().contains(lowerQuery) ??
                false) ||
            (chemical.hazardStatement?.toLowerCase().contains(lowerQuery) ??
                false))
        .toList();
  }

  @override
  Future<List<ChemicalModel>> filterChemicals({
    String? signalWord,
    bool? isBanned,
  }) async {
    Query<Map<String, dynamic>> query = firestore.collection(_collection);

    if (signalWord != null && signalWord.isNotEmpty) {
      query = query.where('signalWord', isEqualTo: signalWord);
    }
    if (isBanned != null) {
      query = query.where('isBanned', isEqualTo: isBanned);
    }

    final snapshot = await query.get();
    final chemicals = snapshot.docs
        .map((doc) => ChemicalModel.fromMap(doc.data(), doc.id))
        .toList();
    chemicals.sort((a, b) =>
        a.commonName.toLowerCase().compareTo(b.commonName.toLowerCase()));
    return chemicals;
  }

  @override
  Future<void> createChemical(ChemicalModel chemical) async {
    await firestore.collection(_collection).add(chemical.toFirestore());
  }

  @override
  Future<void> updateChemical(ChemicalModel chemical) async {
    final data = chemical.toFirestore();
    await firestore.collection(_collection).doc(chemical.id).update(data);
  }

  @override
  Future<void> deleteChemical(String id) async {
    await firestore.collection(_collection).doc(id).delete();
  }
}
