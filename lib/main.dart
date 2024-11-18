import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:notes_app/core/di/dependency_injection.dart';
import 'package:notes_app/core/navigation/router.dart';
import 'package:notes_app/core/notifications/notification_controller.dart';
import 'package:notes_app/firebase_options.dart';

import 'generated/l10n.dart';

void main() async {
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      'resource://drawable/notes_icon',
    // null,
      [
        NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.blueAccent,
        )
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(channelGroupKey: 'basic_channel_group', channelGroupName: 'Basic group')
      ],
      debug: true);

  WidgetsFlutterBinding.ensureInitialized();
  initDependencyInjection();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(NotesApp(
    notesRouter: getIt(),
  ));
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key, required this.notesRouter});

  final NotesRouter notesRouter;

  @override
  Widget build(BuildContext context) {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod: NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod: NotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: NotificationController.onDismissActionReceivedMethod,
    );
    return MaterialApp.router(
      routeInformationProvider: notesRouter.router.routeInformationProvider,
      routeInformationParser: notesRouter.router.routeInformationParser,
      routerDelegate: notesRouter.router.routerDelegate,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.red)),
      darkTheme: ThemeData(colorScheme: ColorScheme.dark()),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
