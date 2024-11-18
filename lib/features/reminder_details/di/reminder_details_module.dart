import 'package:notes_app/core/di/dependency_injection.dart';
import 'package:notes_app/features/notes/data/mappers/reminders_data_mapper.dart';
import 'package:notes_app/features/reminder_details/data/db/reminders_db_service.dart';
import 'package:notes_app/features/reminder_details/data/repository/reminders_local_repository_impl.dart';
import 'package:notes_app/features/reminder_details/domain/reminder_details_interactor.dart';
import 'package:notes_app/features/reminder_details/domain/repository/reminders_local_repository.dart';
import 'package:notes_app/features/reminder_details/presentation/bloc/reminder_details_bloc.dart';

void initReminderDetailsModule() {
  getIt.registerLazySingleton(() => RemindersDbService(notesDatabase: getIt()));
  getIt.registerFactory(() => RemindersDataMapper());
  getIt.registerLazySingleton<RemindersLocalRepository>(
    () => RemindersLocalRepositoryImpl(remindersDbService: getIt(), remindersDataMapper: getIt()),
  );

  getIt.registerLazySingleton(
    () => ReminderDetailsInteractor(remindersLocalRepository: getIt()),
  );

  getIt.registerFactoryParam(
      (DateTime? param1, param2) => ReminderDetailsBloc(reminderDetailsInteractor: getIt(), selectedDay: param1));
}
