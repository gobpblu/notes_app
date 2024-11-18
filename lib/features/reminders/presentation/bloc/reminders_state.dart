part of 'reminders_bloc.dart';

class RemindersState extends Equatable {
  const RemindersState({
    required this.selectedDay,
    this.isLoading = false,
    this.reminders = const [],
  });

  final DateTime selectedDay;
  final bool isLoading;
  final List<ReminderData> reminders;

  RemindersState copyWith({
    DateTime? selectedDay,
    bool? isLoading,
    List<ReminderData>? reminders,
  }) {
    return RemindersState(
      selectedDay: selectedDay ?? this.selectedDay,
      isLoading: isLoading ?? this.isLoading,
      reminders: reminders ?? this.reminders,
    );
  }

  @override
  List<Object?> get props => [selectedDay, isLoading, reminders];
}
