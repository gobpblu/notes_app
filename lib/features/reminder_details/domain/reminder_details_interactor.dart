import 'package:flutter/material.dart';
import 'package:notes_app/features/reminder_details/domain/models/reminder_data.dart';
import 'package:notes_app/features/reminder_details/domain/repository/reminders_local_repository.dart';

class ReminderDetailsInteractor {

  ReminderDetailsInteractor({
    required RemindersLocalRepository remindersLocalRepository,
  })  : _remindersLocalRepository = remindersLocalRepository;

  final RemindersLocalRepository _remindersLocalRepository;

  // final _controller = StreamController<bool>.broadcast();
  //
  // Stream<bool> get notesTriggerStream => _controller.stream;

  Future saveReminder(ReminderData note) async {
    final id = await _remindersLocalRepository.saveReminder(note);
    debugPrint('reminders_interactor => saveNote -> id: $id');
    // final user = _authLocalRepository.getUser();
    // debugPrint('user: $user');
    // if (user == null) return;
    // return _notesRemoteRepository.saveNote(note, user.uid);
  }

  Future<ReminderData?> getReminderById(String id) {
    return _remindersLocalRepository.getReminderById(id);
  }

  Future deleteReminder(String id) async {
    await _remindersLocalRepository.deleteReminder(id);
    // final user = _authLocalRepository.getUser();
    // if (user != null) {
    //   return _notesRemoteRepository.deleteNote(user.uid, id);
    // }
  }

  // Future saveLocalNotesToRemote(List<Note> notes) async {
  //   final user = _authLocalRepository.getUser();
  //   if (user != null) {
  //     for (var note in notes) {
  //       await _notesRemoteRepository.saveNote(note, user.uid);
  //     }
  //   }
  // }

  Future deleteAllLocalReminders() {
    return _remindersLocalRepository.deleteAllLocalReminders();
  }

}