import 'package:firebase_database/firebase_database.dart';
import 'package:notes_app/core/firebase/database/database_references.dart';
import 'package:notes_app/features/notes/data/db/models/note_entity.dart';

class NotesFirebaseService {
  final _ref = FirebaseDatabase.instance.ref(DatabaseReferences.notes);

  Future insertNote(String userId, NoteEntity entity) async {
    return _ref.child(userId).child(entity.id).set(entity.toFirebaseJson());
  }

  Future<List<NoteEntity>> getNotes(String userId) async {
    final dataSnapshot = await _ref.child(userId).get();
    final dynamic maps = dataSnapshot.children.map((e) {
      final key = e.key as String;
      final value = e.value as Map<dynamic, dynamic>;
      return NoteEntity.fromFirebaseJson(key, value);
    }).toList();
    return maps;
  }

// Future<NoteEntity?> getNoteById(int id) async {
//   final db = await _notesDatabase.database;
//   final List<Map<String, dynamic>> maps = await db.query(tableName, where: '$columnId = ?', whereArgs: [id]);
//   return maps.isNotEmpty ? NoteEntity.fromJson(maps[0]) : null;
// }

Future deleteNote(String userId, String noteId) async {
  return _ref.child(userId).child(noteId).remove();
}

}
