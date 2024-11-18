import 'package:notes_app/core/di/dependency_injection.dart';
import 'package:notes_app/features/notes_list/presentation/bloc/notes_list_bloc.dart';

void initNotesListModule() {

  getIt.registerLazySingleton(() => NotesListBloc(notesInteractor: getIt(), authInteractor: getIt()));

}