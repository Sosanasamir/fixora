import 'package:fixora/features/auth/cubit/auth_state.dart';
import 'package:fixora/features/auth/data/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final AuthRepository authRepository = AuthRepository();

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.login(email, password);
      emit(AuthLoginSuccess(user));
    } catch (message) {
      emit(AuthError(message.toString()));
    }
  }

  Future<void> register(
    String name,
    String email,
    String password,
    String phone,
  ) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.register(name, email, password, phone);
      emit(AuthRegisterSuccess(user));
    } catch (message) {
      emit(AuthError(message.toString()));
    }
  }

  Future<void> getCurrentUser() async {
    emit(AuthLoading());
    try {
      final user = await authRepository.getCurrentUser();
      emit(AuthCurrentUserSuccess(user));
    } catch (message) {
      emit(AuthError(message.toString()));
    }
  }

  Future<void> updateProfile(String name, String email, String phone) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.updateProfile(name, email, phone);
      emit(AuthUpdateProfileSuccess(user));
    } catch (message) {
      emit(AuthError(message.toString()));
    }
  }

  void logOut() {
    authRepository.logout();
    emit(AuthInitial());
  }
}
