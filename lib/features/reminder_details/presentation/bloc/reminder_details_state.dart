part of 'reminder_details_bloc.dart';

class ReminderDetailsState extends Equatable {
  const ReminderDetailsState({
    required this.selectedDay,
    required this.type,
    this.id,
    this.isAllDay = false,
    this.needExit = false,
    this.title = "",
    this.isLoading = false,
  });

  final DateTime selectedDay;
  final ReminderType type;
  final bool isAllDay;
  final String? id;
  final bool needExit;
  final String title;
  final bool isLoading;

  ReminderDetailsState copyWith({
    DateTime? selectedDay,
    ReminderType? type,
    bool? isAllDay,
    String? id,
    bool? needExit,
    String? title,
    bool? isLoading,
  }) {
    return ReminderDetailsState(
      selectedDay: selectedDay ?? this.selectedDay,
      type: type ?? this.type,
      isAllDay: isAllDay ?? this.isAllDay,
      id: id ?? this.id,
      needExit: needExit ?? this.needExit,
      title: title ?? this.title,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        selectedDay,
        type,
        isAllDay,
        id,
        needExit,
        title,
        isLoading,
      ];
}
