import 'package:equatable/equatable.dart';
import '../../domain/entities/map.dart';
import '../../domain/entities/place.dart';
import '../../domain/entities/route.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object?> get props => [];
}

class MapInitial extends MapState {}

class MapLoading extends MapState {}

class MapLoaded extends MapState {
  final List<StoreLocationEntity> stores;
  final List<PlaceEntity> searchResults;
  final RouteEntity? route;
  final StoreLocationEntity? directionStore;

  const MapLoaded({
    this.stores = const [],
    this.searchResults = const [],
    this.route,
    this.directionStore,
  });

  @override
  List<Object?> get props => [stores, searchResults, route, directionStore];
}

class MapActionFailure extends MapState {
  final String message;
  const MapActionFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class MapError extends MapState {
  final String message;
  const MapError(this.message);

  @override
  List<Object?> get props => [message];
}
