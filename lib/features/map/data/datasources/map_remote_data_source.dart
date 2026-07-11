import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import '../models/map_model.dart';
import '../models/place_model.dart';
import '../models/route_model.dart';

abstract class MapRemoteDataSource {
  Future<List<StoreLocationModel>> getStoreLocations();
  Future<List<PlaceModel>> searchLocation(String query);
  Future<RouteModel> getDirection({required LatLng from, required LatLng to});
}

class MapRemoteDataSourceImpl implements MapRemoteDataSource {
  final FirebaseFirestore firestore;
  final http.Client client;

  static const String _collection = 'store_locations';

  MapRemoteDataSourceImpl({required this.firestore, required this.client});

  @override
  Future<List<StoreLocationModel>> getStoreLocations() async {
    final snapshot =
        await firestore.collection(_collection).orderBy('name').get();
    return snapshot.docs
        .map((doc) => StoreLocationModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  @override
  Future<List<PlaceModel>> searchLocation(String query) async {
    final uri = Uri.parse(
        'https://nominatim.openstreetmap.org/search?q=${Uri.encodeComponent(query)}&format=json&limit=5&countrycodes=vn&accept-language=vi');
    final response = await client.get(uri, headers: {
      'User-Agent': 'prm393_biopestcontrol',
    });
    if (response.statusCode != 200) {
      throw Exception('Nominatim trả về lỗi: ${response.statusCode}');
    }
    final List results = json.decode(response.body);
    return results
        .map((item) => PlaceModel.fromNominatim(item))
        .toList();
  }

  @override
  Future<RouteModel> getDirection({
    required LatLng from,
    required LatLng to,
  }) async {
    final uri = Uri.parse(
        'https://router.project-osrm.org/route/v1/driving/${from.longitude},${from.latitude};${to.longitude},${to.latitude}?overview=full&geometries=geojson');
    final response = await client.get(uri);
    if (response.statusCode != 200) {
      throw Exception('OSRM trả về lỗi: ${response.statusCode}');
    }
    final data = json.decode(response.body);
    if (data['code'] != 'Ok' || (data['routes'] as List).isEmpty) {
      throw Exception('Không tìm thấy đường đi');
    }
    return RouteModel.fromOsrm(data);
  }
}
