import 'package:notes_app/core/database/notes_database.dart';
import 'package:notes_app/core/navigation/router.dart';

import 'dependency_injection.dart';

void initCoreModule() {
  getIt.registerSingleton(NotesDatabase());
  getIt.registerSingleton(NotesRouter());
}
