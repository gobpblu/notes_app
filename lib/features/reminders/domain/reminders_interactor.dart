import 'package:notes_app/features/reminder_details/domain/models/reminder_data.dart';
import 'package:notes_app/features/reminder_details/domain/repository/reminders_local_repository.dart';

class RemindersInteractor {

  RemindersInteractor({
    required RemindersLocalRepository remindersLocalRepository,
  })  : _remindersLocalRepository = remindersLocalRepository;

  final RemindersLocalRepository _remindersLocalRepository;

  Future<List<ReminderData>> getReminders() async {
    // final user = _authLocalRepository.getUser();
    // debugPrint('NOTES_INTERACTOR -> user: $user');
    // if (user != null) {
    //   debugPrint('NOTES_INTERACTOR -> user: $user');
    //   await _notesLocalRepository.deleteAllLocalNotes();
    //   final notes = await _notesRemoteRepository.getNotes(user.uid);
    //   _remindersLocalRepository.saveRemindersList(notes);
    //   return notes;
    // }
    return _remindersLocalRepository.getReminders();
  }

  Future<List<ReminderData>> getLocalReminders() async {
    return _remindersLocalRepository.getReminders();
  }

}