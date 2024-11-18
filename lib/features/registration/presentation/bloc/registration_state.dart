part of 'registration_bloc.dart';

class RegistrationState extends Equatable {
  final bool isLoading;
  final bool isSuccessfullyRegistered;
  final String email;
  final String password;
  final String? emailErrorText;
  final String? passwordErrorText;

  const RegistrationState({
    required this.isLoading,
    this.isSuccessfullyRegistered = false,
    this.email = "",
    this.password = "",
    this.emailErrorText,
    this.passwordErrorText,
  });

  RegistrationState copyWith({
    bool? isLoading,
    bool? isSuccessfullyRegistered,
    String? email,
    String? password,
    String? Function()? emailErrorText,
    String? Function()? passwordErrorText,
  }) {
    return RegistrationState(
      isLoading: isLoading ?? this.isLoading,
      isSuccessfullyRegistered: isSuccessfullyRegistered ?? this.isSuccessfullyRegistered,
      email: email ?? this.email,
      password: password ?? this.password,
      emailErrorText: emailErrorText != null ? emailErrorText() : this.emailErrorText,
      passwordErrorText: passwordErrorText != null ? passwordErrorText() : this.passwordErrorText,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccessfullyRegistered, email, password, emailErrorText, passwordErrorText];
}
