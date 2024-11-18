import 'package:notes_app/core/di/dependency_injection.dart';
import 'package:notes_app/features/profile/presentation/bloc/profile_bloc.dart';

void initProfileModule() {

  getIt.registerFactory(() => ProfileBloc(authInteractor: getIt(), notesInteractor: getIt()));

}