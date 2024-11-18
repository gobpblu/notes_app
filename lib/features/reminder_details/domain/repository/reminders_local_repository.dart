import 'package:notes_app/features/reminder_details/domain/models/reminder_data.dart';

abstract class RemindersLocalRepository {

  Future<int> saveReminder(ReminderData note);

  Future saveRemindersList(List<ReminderData> notesList);

  Future<List<ReminderData>> getReminders();

  Future<ReminderData?> getReminderById(String id);

  Future<int> deleteReminder(String id);

  Future deleteAllLocalReminders();

}