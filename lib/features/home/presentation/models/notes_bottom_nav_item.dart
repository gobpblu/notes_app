import 'package:notes_app/core/navigation/routes/notes_list_route.dart';
import 'package:notes_app/core/navigation/routes/profile_route.dart';
import 'package:notes_app/core/navigation/routes/reminders_route.dart';

enum NotesBottomNavItem {
  notesList(path: NotesListRoute.name),
  reminders(path: RemindersRoute.name),
  profile(path: ProfileRoute.name);

  final String path;

  const NotesBottomNavItem({required this.path});

  String getRoute() {
    return switch (this) {
      NotesBottomNavItem.notesList => NotesListRoute.name,
      NotesBottomNavItem.reminders => RemindersRoute.name,
      NotesBottomNavItem.profile => ProfileRoute.name,
    };
  }

  static NotesBottomNavItem? from(int index) {
    return NotesBottomNavItem.values.firstWhere(
      (e) => e.index == index,
      orElse: () => NotesBottomNavItem.notesList,
    );
  }
}
