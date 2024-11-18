import 'package:flutter/material.dart';
import 'package:notes_app/features/notes/data/db/models/note_entity.dart';
import 'package:notes_app/features/notes/data/db/notes_db_service.dart';
import 'package:notes_app/features/notes/data/mappers/notes_data_mapper.dart';
import 'package:notes_app/features/notes/domain/models/note.dart';
import 'package:notes_app/features/notes/domain/repository/notes_local_repository.dart';

class NotesLocalRepositoryImpl implements NotesLocalRepository {
  final NotesDbService _notesDbService;
  final NotesDataMapper _notesDataMapper;

  NotesLocalRepositoryImpl({
    required NotesDbService notesDbService,
    required NotesDataMapper notesDataMapper,
  })  : _notesDbService = notesDbService,
        _notesDataMapper = notesDataMapper;

  @override
  Future<int> saveNote(Note note) {
    NoteEntity entity = NoteEntity(id: note.id, title: note.title, content: note.content);
    final id = _notesDbService.insertNote(entity);
    debugPrint('### saveNote -> id: $id');
    return id;
  }

  @override
  Future<List<Note>> getNotes() {
    final entities = _notesDbService.getNotes();
    debugPrint('### getNotes -> entities: $entities');
    return entities.then((list) => list.map(_notesDataMapper.map).toList());
  }

  @override
  Future<Note?> getNoteById(String id) {
    final entity = _notesDbService.getNoteById(id);
    debugPrint('### getNoteById -> entity: $entity');
    return entity.then((e) => e == null ? null : _notesDataMapper.map(e));
  }

  @override
  Future<int> deleteNote(String id) {
    return _notesDbService.deleteNote(id);
  }

  @override
  Future saveNotesList(List<Note> notesList) {
    final entities = notesList.map(_notesDataMapper.mapToEntity).toList();
    return _notesDbService.insertNotesList(entities);
  }

  @override
  Future deleteAllLocalNotes() {
    return _notesDbService.deleteAllNotes();
  }
}
