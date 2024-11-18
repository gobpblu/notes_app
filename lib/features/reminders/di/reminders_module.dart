import 'package:notes_app/core/di/dependency_injection.dart';
import 'package:notes_app/features/reminders/domain/reminders_interactor.dart';
import 'package:notes_app/features/reminders/presentation/bloc/reminders_bloc.dart';

void initRemindersModule() {

  getIt.registerFactory(() => RemindersInteractor(remindersLocalRepository: getIt()));
  getIt.registerFactory(() => RemindersBloc(remindersInteractor: getIt()));

}