import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/features/auth/domain/auth_interactor.dart';
import 'package:notes_app/features/notes/domain/models/note.dart';
import 'package:notes_app/features/notes/domain/notes_interactor.dart';

part 'notes_list_event.dart';

part 'notes_list_state.dart';

class NotesListBloc extends Bloc<NotesListEvent, NotesListState> {
  NotesListBloc({
    required NotesInteractor notesInteractor,
    required AuthInteractor authInteractor,
  })  : _notesInteractor = notesInteractor,
        _authInteractor = authInteractor,
        super(const NotesListState(notes: [])) {
    _observeUser();
    on<NotesDataLoaded>(_onNotesDataLoaded);
    on<NoteDeleted>(_onNoteDeleted);
    on<NotesListActionChanged>(_onNotesListActionChanged);
  }

  final NotesInteractor _notesInteractor;
  final AuthInteractor _authInteractor;

  void _onNotesDataLoaded(
    NotesDataLoaded event,
    Emitter<NotesListState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final notes = await _notesInteractor.getNotes();
      debugPrint('### notesListBLoc -> notes.length: ${notes.length}, notes: $notes');
      emit(state.copyWith(notes: notes, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onNotesListActionChanged(
    NotesListActionChanged event,
    Emitter<NotesListState> emit,
  ) async {
    emit(state.copyWith(currentAction: event.action));
  }

  void _onNoteDeleted(
    NoteDeleted event,
    Emitter<NotesListState> emit,
  ) {
    print('I WORORORORORO');
    final note = event.note;
    final notes = state.notes.toList();
    notes.remove(event.note);
    _notesInteractor.deleteNote(note.id);
    emit(state.copyWith(notes: notes));
  }

  void _observeUser() {
    _authInteractor.observeLocalUser().listen((user) {
      add(NotesDataLoaded());
    });
  }


}
