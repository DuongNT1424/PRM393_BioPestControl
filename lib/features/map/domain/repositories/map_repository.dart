import 'package:dartz/dartz.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/errors/failures.dart';
import '../entities/map.dart';
import '../entities/place.dart';
import '../entities/route.dart';

abstract class MapRepository {
  Future<Either<Failure, List<StoreLocationEntity>>> getStoreLocations();

  Future<Either<Failure, List<PlaceEntity>>> searchLocation(String query);

  Future<Either<Failure, RouteEntity>> getDirection({
    required LatLng from,
    required LatLng to,
  });
}
