import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/features/home/presentation/bloc/home_cubit.dart';
import 'package:notes_app/features/home/presentation/models/notes_bottom_nav_item.dart';
import 'package:notes_app/generated/l10n.dart';

class NotesBottomNavigationBar extends StatelessWidget {
  const NotesBottomNavigationBar({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final currentPath = navigationShell.shellRouteContext.routerState.fullPath;
        final navItemList = NotesBottomNavItem.values.map((e) => e.path);
        debugPrint('list: ${navItemList}');
        debugPrint('route: ${currentPath}');
        if (!navItemList.contains(currentPath)) return const SizedBox();
        return BottomNavigationBar(
          currentIndex: state.index,
          onTap: (index) {
            context.read<HomeCubit>().changeBottomNavItem(index);
            navigationShell.goBranch(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.checklist),
              label: S.of(context).notes,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.list_alt),
              label: S.of(context).reminders,
              // internationalization
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: S.of(context).profile,
            ),
          ],
        );
      },
    );
  }
}
