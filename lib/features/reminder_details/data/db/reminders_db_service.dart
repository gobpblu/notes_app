import 'package:notes_app/core/database/notes_database.dart';
import 'package:sqflite/sqflite.dart';

import 'models/reminder_entity.dart';

class RemindersDbService {
  static const tableName = 'reminders';
  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnDescription = 'description';
  static const columnIsAllDay = 'is_all_day';
  static const columnDate = 'date';
  static const columnType = 'type';

  final NotesDatabase _notesDatabase;

  RemindersDbService({required NotesDatabase notesDatabase}) : _notesDatabase = notesDatabase;

  Future<int> insertReminder(ReminderEntity entity) async {
    final database = await _notesDatabase.database;
    return database.insert(tableName, entity.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future insertRemindersList(List<ReminderEntity> notesList) async {
    final Database db = await _notesDatabase.database;
    final Batch batch = db.batch();

    for (ReminderEntity note in notesList) {
      batch.insert(tableName, note.toJson());
    }

    return batch.commit();
  }

  Future<List<ReminderEntity>> getReminders() async {
    final db = await _notesDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return maps.map((e) => ReminderEntity.fromJson(e)).toList();
  }

  Future<ReminderEntity?> getReminderById(String id) async {
    final db = await _notesDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query(tableName, where: '$columnId = ?', whereArgs: [id]);
    return maps.isNotEmpty ? ReminderEntity.fromJson(maps[0]) : null;
  }

  Future<int> deleteReminder(String id) async {
    final db = await _notesDatabase.database;
    return db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteAllReminders() async {
    final db = await _notesDatabase.database;
    return db.delete(tableName);
  }
}
