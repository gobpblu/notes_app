import 'package:notes_app/generated/l10n.dart';

enum ReminderType {
  event,
  task;

  String getTitle() {
    return switch (this) {
      ReminderType.task => S.current.reminder_task,
      ReminderType.event => S.current.reminder_event
    };
  }

  static ReminderType from(String type) {
    return switch (type) {
      'task' => ReminderType.task,
      'event' => ReminderType.event,
      _ => ReminderType.event,
    };
  }
}
