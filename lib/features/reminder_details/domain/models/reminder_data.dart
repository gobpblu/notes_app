import 'package:equatable/equatable.dart';
import 'package:notes_app/features/reminder_details/presentation/models/reminder_type.dart';

class ReminderData extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool isAllDay;
  final DateTime date;
  final ReminderType type;

  const ReminderData({
    required this.id,
    required this.title,
    required this.description,
    required this.isAllDay,
    required this.date,
    required this.type,
  });

  @override
  List<Object?> get props => [id, title, description, isAllDay, date, type];
}
