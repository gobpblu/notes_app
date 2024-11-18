import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/core/di/dependency_injection.dart';
import 'package:notes_app/core/ui/widgets/notes_bottom_nav_bar.dart';
import 'package:notes_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:notes_app/features/home/presentation/bloc/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // This is just a basic example. For real apps, you must show some
        // friendly dialog box before call the request method.
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          getIt<AuthBloc>()
            ..add(AuthUserSubscribed()),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => getIt<HomeCubit>(),
        ),
      ],
      child: _Body(navigationShell: navigationShell),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
        return Scaffold(
          body: navigationShell,
          bottomNavigationBar: NotesBottomNavigationBar(navigationShell: navigationShell),
        );
      },
    );
  }
}
