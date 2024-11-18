import 'package:notes_app/features/notes/domain/models/note.dart';

abstract class NotesRemoteRepository {
  Future saveNote(Note note, String userId);

  Future<List<Note>> getNotes(String userId);
  //
  // Future<Note?> getNoteById(int id);
  //
  Future deleteNote(String userId, String noteId);
}
