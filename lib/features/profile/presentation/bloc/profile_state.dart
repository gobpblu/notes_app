part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final bool isLoading;
  final User? user;

  const ProfileState({required this.isLoading, this.user});

  ProfileState copyWith({
    bool? isLoading,
    User? Function()? user,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      user: user != null ? user() : this.user,
    );
  }

  @override
  List<Object?> get props => [isLoading, user];
}
