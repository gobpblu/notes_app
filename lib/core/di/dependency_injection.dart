import 'package:get_it/get_it.dart';
import 'package:notes_app/core/di/core_module.dart';
import 'package:notes_app/features/auth/di/auth_module.dart';
import 'package:notes_app/features/home/di/home_module.dart';
import 'package:notes_app/features/login/di/login_module.dart';
import 'package:notes_app/features/notes/di/notes_module.dart';
import 'package:notes_app/features/notes_list/di/notes_list_module.dart';
import 'package:notes_app/features/profile/di/profile_module.dart';
import 'package:notes_app/features/registration/di/registration_module.dart';
import 'package:notes_app/features/reminder_details/di/reminder_details_module.dart';
import 'package:notes_app/features/reminders/di/reminders_module.dart';

final getIt = GetIt.instance;

void initDependencyInjection() {
  initCoreModule();
  initAuthModule();
  initHomeModule();
  initNotesModule();
  initNotesListModule();
  initLoginModule();
  initProfileModule();
  initRegistrationModule();
  initReminderDetailsModule();
  initRemindersModule();
}