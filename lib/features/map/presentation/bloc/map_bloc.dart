import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import '../../domain/usecases/get_maps.dart';
import '../../domain/usecases/search_location.dart';
import '../../domain/usecases/get_direction.dart';
import '../../../../core/usecases/usecase.dart';
import 'map_event.dart';
import 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final GetStoreLocationsUseCase getStoreLocationsUseCase;
  final SearchLocationUseCase searchLocationUseCase;
  final GetDirectionUseCase getDirectionUseCase;

  MapBloc({
    required this.getStoreLocationsUseCase,
    required this.searchLocationUseCase,
    required this.getDirectionUseCase,
  }) : super(MapInitial()) {
    on<LoadStoreLocationsEvent>(_onLoadStoreLocations);
    on<SearchLocationEvent>(_onSearchLocation);
    on<ClearSearchEvent>(_onClearSearch);
    on<GetDirectionEvent>(_onGetDirection);
    on<ClearDirectionEvent>(_onClearDirection);
  }

  MapLoaded get _currentLoaded =>
      state is MapLoaded ? state as MapLoaded : const MapLoaded();

  Future<void> _onLoadStoreLocations(
      LoadStoreLocationsEvent event, Emitter<MapState> emit) async {
    emit(MapLoading());
    final result = await getStoreLocationsUseCase(NoParams());
    result.fold(
      (failure) => emit(MapError(failure.message)),
      (stores) => emit(MapLoaded(stores: stores)),
    );
  }

  Future<void> _onSearchLocation(
      SearchLocationEvent event, Emitter<MapState> emit) async {
    final current = _currentLoaded;
    final result = await searchLocationUseCase(event.query);
    result.fold(
      (failure) {
        emit(MapActionFailure(failure.message));
        emit(current);
      },
      (places) => emit(MapLoaded(
        stores: current.stores,
        searchResults: places,
        route: current.route,
        directionStore: current.directionStore,
      )),
    );
  }

  void _onClearSearch(ClearSearchEvent event, Emitter<MapState> emit) {
    final current = _currentLoaded;
    emit(MapLoaded(
      stores: current.stores,
      searchResults: const [],
      route: current.route,
      directionStore: current.directionStore,
    ));
  }

  Future<void> _onGetDirection(
      GetDirectionEvent event, Emitter<MapState> emit) async {
    final current = _currentLoaded;
    final result = await getDirectionUseCase(GetDirectionParams(
      from: event.from,
      to: LatLng(event.store.latitude, event.store.longitude),
    ));
    result.fold(
      (failure) {
        emit(MapActionFailure(failure.message));
        emit(current);
      },
      (route) => emit(MapLoaded(
        stores: current.stores,
        searchResults: current.searchResults,
        route: route,
        directionStore: event.store,
      )),
    );
  }

  void _onClearDirection(ClearDirectionEvent event, Emitter<MapState> emit) {
    final current = _currentLoaded;
    emit(MapLoaded(
      stores: current.stores,
      searchResults: current.searchResults,
      route: null,
      directionStore: null,
    ));
  }
}
