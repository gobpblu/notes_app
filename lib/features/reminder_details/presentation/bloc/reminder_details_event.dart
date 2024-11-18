part of 'reminder_details_bloc.dart';

sealed class ReminderDetailsEvent extends Equatable {
  const ReminderDetailsEvent();

  @override
  List<Object?> get props => [];
}

class ReminderDetailsDayTapped extends ReminderDetailsEvent {
  final DateTime? selectedDay;

  const ReminderDetailsDayTapped({required this.selectedDay});

  @override
  List<Object?> get props => [selectedDay];
}

class ReminderDetailsTimeSelected extends ReminderDetailsEvent {
  final TimeOfDay? timeOfDay;

  const ReminderDetailsTimeSelected({required this.timeOfDay});

  @override
  List<Object?> get props => [timeOfDay];
}

class ReminderDetailsTypeChanged extends ReminderDetailsEvent {
  final ReminderType type;

  const ReminderDetailsTypeChanged({required this.type});

  @override
  List<Object?> get props => [type];
}

class ReminderDetailsIsAllDayChanged extends ReminderDetailsEvent {
  final bool isAllDay;

  const ReminderDetailsIsAllDayChanged({required this.isAllDay});

  @override
  List<Object?> get props => [isAllDay];
}

class ReminderDetailsSaveButtonClicked extends ReminderDetailsEvent {}

class ReminderDetailsTitleChanged extends ReminderDetailsEvent {
  final String title;

  const ReminderDetailsTitleChanged({required this.title});

  @override
  List<Object?> get props => [title];
}

class ReminderDetailsByIdLoaded extends ReminderDetailsEvent {
  final String? id;

  const ReminderDetailsByIdLoaded({required this.id});

  @override
  List<Object?> get props => [id];
}
