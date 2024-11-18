part of 'reminders_bloc.dart';

sealed class RemindersEvent extends Equatable {

  @override
  List<Object?> get props => [];
}

class RemindersDayTapped extends RemindersEvent {

  final DateTime selectedDay;

  RemindersDayTapped({required this.selectedDay});

  @override
  List<Object?> get props => [selectedDay];
}

class RemindersDataLoaded extends RemindersEvent {}