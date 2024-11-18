import 'package:flutter/material.dart';
import 'package:notes_app/features/notes/data/db/models/note_entity.dart';
import 'package:notes_app/features/notes/data/db/notes_db_service.dart';
import 'package:notes_app/features/notes/data/mappers/notes_data_mapper.dart';
import 'package:notes_app/features/notes/data/service/notes_firebase_service.dart';
import 'package:notes_app/features/notes/domain/models/note.dart';
import 'package:notes_app/features/notes/domain/repository/notes_local_repository.dart';
import 'package:notes_app/features/notes/domain/repository/notes_remote_repository.dart';

class NotesRemoteRepositoryImpl implements NotesRemoteRepository {
  final NotesFirebaseService _notesFirebaseService;
  final NotesDataMapper _notesDataMapper;

  NotesRemoteRepositoryImpl({
    required NotesFirebaseService notesFirebaseService,
    required NotesDataMapper notesDataMapper,
  })
      : _notesFirebaseService = notesFirebaseService,
        _notesDataMapper = notesDataMapper;

  @override
  Future saveNote(Note note, String userId) {
    NoteEntity entity = _notesDataMapper.mapToEntity(note);
    return _notesFirebaseService.insertNote(userId, entity);
  }

  @override
  Future<List<Note>> getNotes(String userId) async {
    return _notesFirebaseService.getNotes(userId).then((list) => list.map(_notesDataMapper.map).toList());
  }

  @override
  Future deleteNote(String userId, String noteId) {
   return _notesFirebaseService.deleteNote(userId, noteId);
  }
}
