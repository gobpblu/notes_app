import 'package:notes_app/core/di/dependency_injection.dart';
import 'package:notes_app/features/home/presentation/bloc/home_cubit.dart';

void initHomeModule() {

  getIt.registerFactory(() => HomeCubit());

}