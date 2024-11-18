part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final User? user;
  final bool isLoading;

  const AuthState({this.user, required this.isLoading});

  AuthState copyWith({
    User? user,
    bool? isLoading,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [user, isLoading];
}
