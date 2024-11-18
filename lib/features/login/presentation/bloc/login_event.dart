part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginGoogleIconClicked extends LoginEvent {}

class LoginAppleIconClicked extends LoginEvent {}

class LoginEmailChanged extends LoginEvent {
  final String email;

  const LoginEmailChanged({required this.email});

  @override
  List<Object?> get props => [email];
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  const LoginPasswordChanged({required this.password});

  @override
  List<Object?> get props => [password];
}

class LoginSignInButtonClicked extends LoginEvent {}

class LoginSaveLocalDataYesButtonClicked extends LoginEvent {}