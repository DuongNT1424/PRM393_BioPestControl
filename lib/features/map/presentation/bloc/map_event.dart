import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';
import '../../domain/entities/map.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object?> get props => [];
}

class LoadStoreLocationsEvent extends MapEvent {}

class SearchLocationEvent extends MapEvent {
  final String query;
  const SearchLocationEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class ClearSearchEvent extends MapEvent {}

class GetDirectionEvent extends MapEvent {
  final LatLng from;
  final StoreLocationEntity store;
  const GetDirectionEvent({required this.from, required this.store});

  @override
  List<Object?> get props => [from, store];
}

class ClearDirectionEvent extends MapEvent {}
