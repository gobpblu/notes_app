import 'package:flutter/material.dart';
import 'package:notes_app/features/notes/data/db/notes_db_service.dart';
import 'package:notes_app/features/reminder_details/data/db/reminders_db_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NotesDatabase {
  static const String _databaseName = 'notes.db';
  static const int _databaseVersion = 1;

  Database? _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initDatabase();
    }
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    final path = join(databasePath, _databaseName);

    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: _databaseVersion,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    debugPrint('\#\#\# _onCreate');
   /* await db.execute('''
    CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT)
    ''');*/
    await db.execute('''
    CREATE TABLE ${NotesDbService.tableName}(
    ${NotesDbService.columnId} TEXT PRIMARY KEY,
    ${NotesDbService.columnTitle} TEXT, 
    ${NotesDbService.columnContent} TEXT
    )
    ''');
    await db.execute('''
    CREATE TABLE ${RemindersDbService.tableName}(
    ${RemindersDbService.columnId} TEXT PRIMARY KEY,
    ${RemindersDbService.columnTitle} TEXT, 
    ${RemindersDbService.columnDescription} TEXT,
    ${RemindersDbService.columnIsAllDay} INTEGER,
    ${RemindersDbService.columnDate} TEXT,
    ${RemindersDbService.columnType} TEXT
    )
    ''');
  }
}
