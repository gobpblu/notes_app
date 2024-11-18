import 'package:equatable/equatable.dart';
import 'package:notes_app/features/notes/data/db/notes_db_service.dart';

class NoteEntity extends Equatable {
  final String id;
  final String title;
  final String content;

  const NoteEntity({
    required this.id,
    required this.title,
    required this.content,
  });

  factory NoteEntity.fromJson(Map<String, dynamic> json) {
    return NoteEntity(
      id: json[NotesDbService.columnId],
      title: json[NotesDbService.columnTitle],
      content: json[NotesDbService.columnContent],
    );
  }

  factory NoteEntity.fromFirebaseJson(String id, Map<dynamic, dynamic> json) {
    return NoteEntity(
      id: id,
      title: json[NotesDbService.columnTitle],
      content: json[NotesDbService.columnContent],
    );
  }

  Map<String, dynamic> toJson() => {
        NotesDbService.columnId: id,
        NotesDbService.columnTitle: title,
        NotesDbService.columnContent: content,
      };

  Map<String, dynamic> toFirebaseJson() => {
        NotesDbService.columnTitle: title,
        NotesDbService.columnContent: content,
      };

  @override
  List<Object?> get props => [
        id,
        title,
        content,
      ];

  @override
  String toString() {
    return 'NoteEntity{id: $id, title: $title, content: $content}';
  }
}
