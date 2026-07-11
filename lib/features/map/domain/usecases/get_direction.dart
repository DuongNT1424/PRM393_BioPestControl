import 'package:dartz/dartz.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/errors/failures.dart';
import '../entities/route.dart';
import '../repositories/map_repository.dart';

class GetDirectionParams {
  final LatLng from;
  final LatLng to;

  const GetDirectionParams({required this.from, required this.to});
}

class GetDirectionUseCase {
  final MapRepository repository;

  GetDirectionUseCase(this.repository);

  Future<Either<Failure, RouteEntity>> call(GetDirectionParams params) {
    return repository.getDirection(from: params.from, to: params.to);
  }
}
