part of 'registration_bloc.dart';

sealed class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object?> get props => [];
}

class RegistrationEmailChanged extends RegistrationEvent {
  final String email;

  const RegistrationEmailChanged({required this.email});

  @override
  List<Object?> get props => [email];
}

class RegistrationPasswordChanged extends RegistrationEvent {
  final String password;

  const RegistrationPasswordChanged({required this.password});

  @override
  List<Object?> get props => [password];
}

class RegistrationRegisterButtonClicked extends RegistrationEvent {
  const RegistrationRegisterButtonClicked();
}