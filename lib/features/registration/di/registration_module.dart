import 'package:notes_app/core/di/dependency_injection.dart';
import 'package:notes_app/features/registration/presentation/bloc/registration_bloc.dart';

void initRegistrationModule() {

  getIt.registerFactory(() => RegistrationBloc(authInteractor: getIt()));
}