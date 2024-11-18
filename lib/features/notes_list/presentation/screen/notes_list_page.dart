import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/core/di/dependency_injection.dart';
import 'package:notes_app/core/navigation/routes/note_route.dart';
import 'package:notes_app/features/notes/domain/models/note.dart';
import 'package:notes_app/features/notes_list/presentation/bloc/notes_list_bloc.dart';
import 'package:notes_app/main.dart';
import 'package:path/path.dart';

class NotesListPage extends StatelessWidget {
  const NotesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<NotesListBloc>()..add(NotesDataLoaded()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('NOTES LIST'),
          actions: [IconButton(onPressed: _showNotification, icon: Icon(Icons.access_time))],
        ),
        body: _Body(),
        floatingActionButton: _CreateButton(),
      ),
    );
  }

  void _showNotification() async {
    // AwesomeNotifications().createNotification(
    //     content: NotificationContent(
    //       id: 10,
    //       channelKey: 'basic_channel',
    //       actionType: ActionType.Default,
    //       title: 'Hello EVERYBODY!',
    //       body: 'SECONDDNDNNDSGNFDSNFNAS!',
    //     )
    // );
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: 'Wait 5 seconds to show',
        body: 'Now it is 5 seconds later.',
        wakeUpScreen: true,
        category: NotificationCategory.Alarm,
      ),
      schedule: NotificationInterval(
          interval: 5,
          // timeZone: localTimeZone,
          preciseAlarm: true,
          timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
      ),
    );
  }
}

class _CreateButton extends StatelessWidget {
  const _CreateButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final notesListBloc = context.read<NotesListBloc>();
    return FloatingActionButton(
      child: Icon(Icons.note_add_outlined),
      onPressed: () {
        context.push('/note').then((value) {
          if (value == true) {
            notesListBloc.add(NotesDataLoaded());
          }
        });
      },
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({super.key});

  @override
  Widget build(BuildContext context) {
    final notesListBloc = context.read<NotesListBloc>();
    return BlocBuilder<NotesListBloc, NotesListState>(
      builder: (context, state) {
        if (state.isLoading) return const Center(child: CircularProgressIndicator());
        final notes = state.notes;
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            final note = notes[index];
            return Slidable(
              key: ValueKey(note.id),
              startActionPane: ActionPane(
                motion: ScrollMotion(),
                dismissible: DismissiblePane(
                  onDismissed: () {
                    notesListBloc.add(NoteDeleted(note: note));
                  },
                ),
                children: [
                  SlidableAction(
                    // An action can be bigger than the others.
                    flex: 2,
                    onPressed: (context) {
                      notesListBloc.add(NoteDeleted(note: note));
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    // label: 'Delete',
                  ),
                ],
              ),
              endActionPane: ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    // An action can be bigger than the others.
                    flex: 1,
                    spacing: 2,
                    onPressed: (context) {
                      notesListBloc.add(NoteDeleted(note: note));
                    },
                    borderRadius: BorderRadius.only(topRight: Radius.circular(25), bottomRight: Radius.circular(25)),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    icon: Icons.accessible_forward_sharp,
                    // label: 'Delete',
                  ),
                  SlidableAction(
                    // An action can be bigger than the others.
                    flex: 1,
                    spacing: 1,
                    onPressed: (context) {
                      notesListBloc.add(NoteDeleted(note: note));
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              ),
              child: ListTile(
                leading: Icon(Icons.notes_outlined),
                title: Text(
                  note.title,
                  style: TextStyle(fontSize: 20),
                ),
                trailing: _ActionsDropdown(note: note),
                subtitle: Text(note.content),
                onTap: () {
                  final id = note.id;
                  context.push(NoteRoute.getRouteWithArgs(id)).then((value) {
                    if (value == true) {
                      notesListBloc.add(NotesDataLoaded());
                    }
                  });
                },
              ),
            );
          },
          itemCount: notes.length,
        );
      },
    );
  }
}

class _ActionsDropdown extends StatelessWidget {
  const _ActionsDropdown({
    super.key,
    required this.note,
  });

  final Note note;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<NotesListBloc>();
    return BlocBuilder<NotesListBloc, NotesListState>(
      builder: (context, state) {
        print('currentAction: ${state.currentAction}');
        return DropdownButton(
          icon: Icon(Icons.abc_sharp),
          underline: null,
          iconSize: 40,

          // value: state.currentAction,
          items: [
            DropdownMenuItem<String>(
              value: 'DELETE',
              child: Text('DELETE'),
              onTap: () {
                bloc.add(NoteDeleted(note: note));
              },
            ),
            DropdownMenuItem<String>(
              value: 'EDIT',
              child: Text('EDIT'),
              onTap: () {
                final id = note.id;
                context.push(NoteRoute.getRouteWithArgs(id)).then((value) {
                  if (value == true) {
                    bloc.add(NotesDataLoaded());
                  }
                });
              },
            ),
          ],
          onChanged: (action) {
            print('action: $action');
            bloc.add(NotesListActionChanged(action: action));
          },
        );
      },
    );
  }
}
