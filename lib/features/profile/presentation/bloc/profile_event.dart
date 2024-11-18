part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class ProfileUserSubscribed extends ProfileEvent {}

class ProfileUserChanged extends ProfileEvent {
  final User? user;

  const ProfileUserChanged({required this.user});

  @override
  List<Object?> get props => [user];
}

class ProfileCurrentUserLoaded extends ProfileEvent {}

class ProfileLogOutButtonClicked extends ProfileEvent {}
