import 'notes_list_route.dart';

class NoteRoute {
  static const String idKeyArg = "id";

  static const String name = 'note';

  static String getRouteWithArgs(String id) {
    return '${NotesListRoute.name}$name?$idKeyArg=$id';
    // identical to -> if (id == 5) then '/note?id=5'
  }
}