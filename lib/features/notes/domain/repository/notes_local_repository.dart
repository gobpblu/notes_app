import 'package:notes_app/features/notes/domain/models/note.dart';

abstract class NotesLocalRepository {
  Future<int> saveNote(Note note);

  Future saveNotesList(List<Note> notesList);

  Future<List<Note>> getNotes();

  Future<Note?> getNoteById(String id);

  Future<int> deleteNote(String id);

  Future deleteAllLocalNotes();
}
