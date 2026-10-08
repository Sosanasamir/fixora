import 'package:equatable/equatable.dart';
import 'package:fixora/features/auth/data/user_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthLoginSuccess extends AuthState {
  final UserModel user;
  const AuthLoginSuccess(this.user);
  @override
  List<Object?> get props => [user];
}

class AuthRegisterSuccess extends AuthState {
  final UserModel user;
  const AuthRegisterSuccess(this.user);
  @override
  List<Object?> get props => [user];
}

class AuthCurrentUserSuccess extends AuthState {
  final UserModel user;
  const AuthCurrentUserSuccess(this.user);
  @override
  List<Object?> get props => [user];
}

class AuthUpdateProfileSuccess extends AuthState {
  final UserModel user;
  const AuthUpdateProfileSuccess(this.user);
  @override
  List<Object?> get props => [user];
}

class AuthChangePasswordSuccess extends AuthState {
  const AuthChangePasswordSuccess();
}

class AuthUpdateProfileAndPasswordSuccess extends AuthState {
  const AuthUpdateProfileAndPasswordSuccess();
}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
  @override
  List<Object?> get props => [message];
}
