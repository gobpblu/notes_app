import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/core/navigation/routes/login_route.dart';
import 'package:notes_app/core/navigation/routes/note_route.dart';
import 'package:notes_app/core/navigation/routes/notes_list_route.dart';
import 'package:notes_app/core/navigation/routes/registration_route.dart';
import 'package:notes_app/core/navigation/routes/reminder_details_route.dart';
import 'package:notes_app/core/navigation/routes/reminders_route.dart';
import 'package:notes_app/features/home/presentation/screen/home_page.dart';
import 'package:notes_app/features/login/presentation/screen/login_page.dart';
import 'package:notes_app/features/notes/presentation/screen/note_page.dart';
import 'package:notes_app/features/notes_list/presentation/screen/notes_list_page.dart';
import 'package:notes_app/features/profile/presentation/screen/profile_page.dart';
import 'package:notes_app/features/registration/presentation/screen/registration_page.dart';
import 'package:notes_app/features/reminder_details/presentation/screen/reminder_details_page.dart';
import 'package:notes_app/features/reminders/presentation/screen/reminders_page.dart';

import 'routes/profile_route.dart';

class NotesRouter {
  final GoRouter _router = GoRouter(
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, child) => HomePage(navigationShell: child),
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: [
              GoRoute(
                  path: NotesListRoute.name,
                  pageBuilder: (context, state) => const MaterialPage(
                        child: NotesListPage(),
                      ),
                  routes: [
                    GoRoute(
                      name: NoteRoute.name,
                      path: NoteRoute.name,
                      pageBuilder: (context, state) {
                        final id = state.uri.queryParameters[NoteRoute.idKeyArg];
                        return MaterialPage(
                          child: NotePage(id: id),
                        );
                      },
                    ),
                  ]),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RemindersRoute.name,
                pageBuilder: (context, state) => const MaterialPage(
                  child: RemindersPage(),
                ),
                routes: [
                  GoRoute(
                    name: ReminderDetailsRoute.name,
                    path: ReminderDetailsRoute.name,
                    pageBuilder: (context, state) {
                      final queryParams = state.uri.queryParameters;
                      final stringDate = queryParams[ReminderDetailsRoute.dateKeyArg];
                      final date = DateTime.tryParse(stringDate ?? '');
                      final id = queryParams[ReminderDetailsRoute.idKeyArg];
                      print('ROUTER STRING_DATE => $stringDate');
                      print('ROUTER DATE => $date');
                      return MaterialPage(
                        child: ReminderDetailsPage(date: date, id: id),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                  path: ProfileRoute.name,
                  name: ProfileRoute.name,
                  pageBuilder: (context, state) => const MaterialPage(
                        child: ProfilePage(),
                      ),
                  routes: [
                    GoRoute(
                        path: LoginRoute.name,
                        name: LoginRoute.name,
                        pageBuilder: (context, state) => const MaterialPage(
                              child: LoginPage(),
                            ),
                        routes: [
                          GoRoute(
                            name: RegistrationRoute.name,
                            path: RegistrationRoute.name,
                            pageBuilder: (context, state) => const MaterialPage(
                              child: RegistrationPage(),
                            ),
                          ),
                        ]),
                  ]),
            ],
          ),
        ],
      ),
    ],
  );

  GoRouter get router => _router;
}
