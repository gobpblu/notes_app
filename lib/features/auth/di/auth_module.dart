import 'package:notes_app/core/di/dependency_injection.dart';
import 'package:notes_app/features/auth/data/repository/auth_local_repository_impl.dart';
import 'package:notes_app/features/auth/data/repository/auth_remote_repository_impl.dart';
import 'package:notes_app/features/auth/data/service/firebase_auth_service.dart';
import 'package:notes_app/features/auth/domain/auth_interactor.dart';
import 'package:notes_app/features/auth/domain/repository/auth_local_repository.dart';
import 'package:notes_app/features/auth/domain/repository/auth_remote_repository.dart';
import 'package:notes_app/features/auth/presentation/bloc/auth_bloc.dart';

void initAuthModule() {

  getIt.registerLazySingleton(() => FirebaseAuthService());
  getIt.registerLazySingleton<AuthRemoteRepository>(() => AuthRemoteRepositoryImpl(authService: getIt()));
  getIt.registerLazySingleton<AuthLocalRepository>(() => AuthLocalRepositoryImpl());
  getIt.registerFactory(() => AuthInteractor(remoteRepository: getIt(), localRepository: getIt()));
  getIt.registerLazySingleton(() => AuthBloc(authInteractor: getIt()));

}