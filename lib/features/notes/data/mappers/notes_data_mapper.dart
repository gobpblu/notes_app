import 'package:notes_app/features/notes/data/db/models/note_entity.dart';
import 'package:notes_app/features/notes/domain/models/note.dart';

class NotesDataMapper {

  Note map(NoteEntity entity) {
    return Note(
      id: entity.id,
      title: entity.title,
      content: entity.content,
    );
  }

  NoteEntity mapToEntity(Note entity) {
    return NoteEntity(
      id: entity.id,
      title: entity.title,
      content: entity.content,
    );
  }
}