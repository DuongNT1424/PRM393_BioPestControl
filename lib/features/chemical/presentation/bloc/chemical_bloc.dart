import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_chemicals_usecase.dart';
import '../../domain/usecases/search_chemicals_usecase.dart';
import '../../domain/usecases/filter_chemicals_usecase.dart';
import '../../domain/usecases/create_chemical_usecase.dart';
import '../../domain/usecases/update_chemical_usecase.dart';
import '../../domain/usecases/delete_chemical_usecase.dart';
import '../../../../core/usecases/usecase.dart';
import 'chemical_event.dart';
import 'chemical_state.dart';

class ChemicalBloc extends Bloc<ChemicalEvent, ChemicalState> {
  final GetChemicalsUseCase getChemicalsUseCase;
  final SearchChemicalsUseCase searchChemicalsUseCase;
  final FilterChemicalsUseCase filterChemicalsUseCase;
  final CreateChemicalUseCase createChemicalUseCase;
  final UpdateChemicalUseCase updateChemicalUseCase;
  final DeleteChemicalUseCase deleteChemicalUseCase;

  ChemicalBloc({
    required this.getChemicalsUseCase,
    required this.searchChemicalsUseCase,
    required this.filterChemicalsUseCase,
    required this.createChemicalUseCase,
    required this.updateChemicalUseCase,
    required this.deleteChemicalUseCase,
  }) : super(ChemicalInitial()) {
    on<LoadChemicalsEvent>(_onLoadChemicals);
    on<SearchChemicalsEvent>(_onSearchChemicals);
    on<FilterChemicalsEvent>(_onFilterChemicals);
    on<CreateChemicalEvent>(_onCreateChemical);
    on<UpdateChemicalEvent>(_onUpdateChemical);
    on<DeleteChemicalEvent>(_onDeleteChemical);
  }

  Future<void> _onLoadChemicals(
      LoadChemicalsEvent event, Emitter<ChemicalState> emit) async {
    emit(ChemicalLoading());
    final result = await getChemicalsUseCase(NoParams());
    result.fold(
      (failure) => emit(ChemicalError(failure.message)),
      (chemicals) => emit(ChemicalLoaded(chemicals)),
    );
  }

  Future<void> _onSearchChemicals(
      SearchChemicalsEvent event, Emitter<ChemicalState> emit) async {
    emit(ChemicalLoading());
    final result = await searchChemicalsUseCase(event.query);
    result.fold(
      (failure) => emit(ChemicalError(failure.message)),
      (chemicals) => emit(ChemicalLoaded(chemicals)),
    );
  }

  Future<void> _onFilterChemicals(
      FilterChemicalsEvent event, Emitter<ChemicalState> emit) async {
    emit(ChemicalLoading());
    final result = await filterChemicalsUseCase(FilterChemicalsParams(
      signalWord: event.signalWord,
      isBanned: event.isBanned,
    ));
    result.fold(
      (failure) => emit(ChemicalError(failure.message)),
      (chemicals) => emit(ChemicalLoaded(chemicals)),
    );
  }

  Future<void> _onCreateChemical(
      CreateChemicalEvent event, Emitter<ChemicalState> emit) async {
    emit(ChemicalLoading());
    final result = await createChemicalUseCase(event.chemical);
    result.fold(
      (failure) => emit(ChemicalError(failure.message)),
      (_) {
        emit(const ChemicalActionSuccess('Thêm hóa chất thành công'));
        add(LoadChemicalsEvent());
      },
    );
  }

  Future<void> _onUpdateChemical(
      UpdateChemicalEvent event, Emitter<ChemicalState> emit) async {
    emit(ChemicalLoading());
    final result = await updateChemicalUseCase(event.chemical);
    result.fold(
      (failure) => emit(ChemicalError(failure.message)),
      (_) {
        emit(const ChemicalActionSuccess('Cập nhật hóa chất thành công'));
        add(LoadChemicalsEvent());
      },
    );
  }

  Future<void> _onDeleteChemical(
      DeleteChemicalEvent event, Emitter<ChemicalState> emit) async {
    emit(ChemicalLoading());
    final result = await deleteChemicalUseCase(event.id);
    result.fold(
      (failure) => emit(ChemicalError(failure.message)),
      (_) {
        emit(const ChemicalActionSuccess('Xóa hóa chất thành công'));
        add(LoadChemicalsEvent());
      },
    );
  }
}
