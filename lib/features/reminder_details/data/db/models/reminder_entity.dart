import 'package:equatable/equatable.dart';
import 'package:notes_app/features/reminder_details/data/db/reminders_db_service.dart';

class ReminderEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool isAllDay;
  final String date;
  final String type;

  const ReminderEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.isAllDay,
    required this.date,
    required this.type,
  });

  factory ReminderEntity.fromJson(Map<String, dynamic> json) {
    return ReminderEntity(
      id: json[RemindersDbService.columnId],
      title: json[RemindersDbService.columnTitle],
      description: json[RemindersDbService.columnDescription],
      isAllDay: json[RemindersDbService.columnIsAllDay] == 0 ? false : true,
      date: json[RemindersDbService.columnDate],
      type: json[RemindersDbService.columnType],
    );
  }

  // factory NoteEntity.fromFirebaseJson(String id, Map<dynamic, dynamic> json) {
  //   return NoteEntity(
  //     id: id,
  //     title: json[NotesDbService.columnTitle],
  //     content: json[NotesDbService.columnContent],
  //   );
  // }

  Map<String, dynamic> toJson() => {
        RemindersDbService.columnId: id,
        RemindersDbService.columnTitle: title,
        RemindersDbService.columnDescription: description,
        RemindersDbService.columnIsAllDay: isAllDay ? 1 : 0,
        RemindersDbService.columnDate: date,
        RemindersDbService.columnType: type,
      };

  // Map<String, dynamic> toFirebaseJson() => {
  //       NotesDbService.columnTitle: title,
  //       NotesDbService.columnContent: content,
  //     };
  //
  @override
  List<Object?> get props => [
        id,
        title,
        description,
        isAllDay,
        date,
        type,
      ];

  @override
  String toString() {
    return 'ReminderEntity{id: $id, title: $title, description: $description, isAllDay: $isAllDay, date: $date, type: $type}';
  }
}
