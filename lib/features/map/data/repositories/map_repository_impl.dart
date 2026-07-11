import 'package:dartz/dartz.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/map.dart';
import '../../domain/entities/place.dart';
import '../../domain/entities/route.dart';
import '../../domain/repositories/map_repository.dart';
import '../datasources/map_remote_data_source.dart';

class MapRepositoryImpl implements MapRepository {
  final MapRemoteDataSource remoteDataSource;

  MapRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<StoreLocationEntity>>>
      getStoreLocations() async {
    try {
      final result = await remoteDataSource.getStoreLocations();
      return Right(result);
    } catch (e) {
      return const Left(
          ServerFailure('Không thể tải danh sách cửa hàng/kho'));
    }
  }

  @override
  Future<Either<Failure, List<PlaceEntity>>> searchLocation(
      String query) async {
    try {
      final result = await remoteDataSource.searchLocation(query);
      return Right(result);
    } catch (e) {
      return const Left(ServerFailure('Lỗi khi tìm kiếm địa điểm'));
    }
  }

  @override
  Future<Either<Failure, RouteEntity>> getDirection({
    required LatLng from,
    required LatLng to,
  }) async {
    try {
      final result =
          await remoteDataSource.getDirection(from: from, to: to);
      return Right(result);
    } catch (e) {
      return const Left(ServerFailure('Không thể tìm đường đi'));
    }
  }
}
