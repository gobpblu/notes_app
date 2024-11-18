import 'package:notes_app/core/navigation/routes/reminders_route.dart';

class ReminderDetailsRoute {

  static const String dateKeyArg = "date";
  static const String idKeyArg = "id";

  static const String name = 'reminder_details';

  static String getRouteWithArgs({required DateTime date, String? id}) {
    final buffer = StringBuffer('${RemindersRoute.name}/$name?$dateKeyArg=$date');
    if (id != null) {
      buffer.write('&$idKeyArg=$id');
    }
    return buffer.toString();
  }
}