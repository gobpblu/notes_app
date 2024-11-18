import 'package:notes_app/core/di/dependency_injection.dart';
import 'package:notes_app/features/login/presentation/bloc/login_bloc.dart';

void initLoginModule() {

  getIt.registerFactory(() => LoginBloc(authInteractor: getIt(), notesInteractor: getIt()));

}