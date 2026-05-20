import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/update_profile_usecase.dart';
import '../../domain/usecases/change_password_usecase.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UpdateProfileUseCase updateProfileUseCase;
  final ChangePasswordUseCase changePasswordUseCase;

  ProfileBloc({
    required this.updateProfileUseCase,
    required this.changePasswordUseCase,
  }) : super(ProfileInitial()) {
    on<UpdateProfileRequested>(_onUpdateProfileRequested);
    on<ChangePasswordRequested>(_onChangePasswordRequested);
  }

  Future<void> _onUpdateProfileRequested(UpdateProfileRequested event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final result = await updateProfileUseCase(UpdateProfileParams(name: event.name, photoUrl: event.photoUrl));
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (user) => emit(ProfileUpdateSuccess(user)),
    );
  }

  Future<void> _onChangePasswordRequested(ChangePasswordRequested event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final result = await changePasswordUseCase(ChangePasswordParams(
      oldPassword: event.oldPassword,
      newPassword: event.newPassword,
    ));
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (_) => emit(ChangePasswordSuccess()),
    );
  }
}
