import 'package:flutter/material.dart';
import 'package:notes_app/features/notes/data/db/models/note_entity.dart';
import 'package:notes_app/features/notes/data/db/notes_db_service.dart';
import 'package:notes_app/features/notes/data/mappers/notes_data_mapper.dart';
import 'package:notes_app/features/notes/data/mappers/reminders_data_mapper.dart';
import 'package:notes_app/features/notes/domain/models/note.dart';
import 'package:notes_app/features/notes/domain/repository/notes_local_repository.dart';
import 'package:notes_app/features/reminder_details/data/db/models/reminder_entity.dart';
import 'package:notes_app/features/reminder_details/data/db/reminders_db_service.dart';
import 'package:notes_app/features/reminder_details/domain/models/reminder_data.dart';
import 'package:notes_app/features/reminder_details/domain/repository/reminders_local_repository.dart';

class RemindersLocalRepositoryImpl implements RemindersLocalRepository {
  final RemindersDbService _remindersDbService;
  final RemindersDataMapper _remindersDataMapper;

  RemindersLocalRepositoryImpl({
    required RemindersDbService remindersDbService,
    required RemindersDataMapper remindersDataMapper,
  })  : _remindersDbService = remindersDbService,
        _remindersDataMapper = remindersDataMapper;

  @override
  Future<int> saveReminder(ReminderData data) {
    ReminderEntity entity = _remindersDataMapper.mapToEntity(data);
    final id = _remindersDbService.insertReminder(entity);
    debugPrint('### saveReminder -> id: $id');
    return id;
  }

  @override
  Future<List<ReminderData>> getReminders() {
    final entities = _remindersDbService.getReminders();
    debugPrint('### getReminders -> entities: $entities');
    return entities.then((list) => list.map(_remindersDataMapper.map).toList());
  }

  @override
  Future<ReminderData?> getReminderById(String id) {
    final entity = _remindersDbService.getReminderById(id);
    debugPrint('### getReminderById -> entity: $entity');
    return entity.then((e) => e == null ? null : _remindersDataMapper.map(e));
  }

  @override
  Future<int> deleteReminder(String id) {
    return _remindersDbService.deleteReminder(id);
  }

  @override
  Future saveRemindersList(List<ReminderData> notesList) {
    final entities = notesList.map(_remindersDataMapper.mapToEntity).toList();
    return _remindersDbService.insertRemindersList(entities);
  }

  @override
  Future deleteAllLocalReminders() {
    return _remindersDbService.deleteAllReminders();
  }
}
