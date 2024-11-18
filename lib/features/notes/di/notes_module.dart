import 'package:notes_app/core/di/dependency_injection.dart';
import 'package:notes_app/features/notes/data/db/notes_db_service.dart';
import 'package:notes_app/features/notes/data/mappers/notes_data_mapper.dart';
import 'package:notes_app/features/notes/data/repository/notes_local_repository_impl.dart';
import 'package:notes_app/features/notes/data/repository/notes_remote_repository_impl.dart';
import 'package:notes_app/features/notes/data/service/notes_firebase_service.dart';
import 'package:notes_app/features/notes/domain/notes_interactor.dart';
import 'package:notes_app/features/notes/domain/repository/notes_local_repository.dart';
import 'package:notes_app/features/notes/domain/repository/notes_remote_repository.dart';
import 'package:notes_app/features/notes/presentation/cubit/note_cubit.dart';

void initNotesModule() {
  getIt.registerLazySingleton(() => NotesDbService(notesDatabase: getIt()));
  getIt.registerLazySingleton(() => NotesFirebaseService());
  getIt.registerFactory(() => NotesDataMapper());

  getIt.registerLazySingleton<NotesLocalRepository>(() => NotesLocalRepositoryImpl(
        notesDbService: getIt(),
        notesDataMapper: getIt(),
      ));
  getIt.registerLazySingleton<NotesRemoteRepository>(() => NotesRemoteRepositoryImpl(
        notesFirebaseService: getIt(),
        notesDataMapper: getIt(),
      ));

  getIt.registerFactory(() => NotesInteractor(
        notesLocalRepository: getIt(),
        notesRemoteRepository: getIt(),
        authLocalRepository: getIt(),
      ));

  getIt.registerFactoryParam((String? param1, param2) => NoteCubit(id: param1, notesInteractor: getIt()));
}
