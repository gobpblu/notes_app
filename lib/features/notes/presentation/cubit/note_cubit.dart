import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/features/notes/domain/models/note.dart';
import 'package:notes_app/features/notes/domain/notes_interactor.dart';
import 'package:uuid/uuid.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit({
    String? id,
    required NotesInteractor notesInteractor,
  })  : _notesInteractor = notesInteractor,
        super(NoteState(title: '', content: '')) {

    if (id != null) _loadNoteById(id);
  }

  final NotesInteractor _notesInteractor;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  void updateTitle(String name) {
    debugPrint('### noteCubit -> updateTitle -> title: $name');
    emit(state.copyWith(title: name));
  }

  void updateContent(String content) {
    debugPrint('### noteCubit -> updateContent -> content: $content');
    emit(state.copyWith(content: content));
  }

  void saveNote() async {
    final id = state.id ?? const Uuid().v4();
    final note = Note(id: id, title: titleController.text, content: contentController.text);
    await _notesInteractor.saveNote(note);
    debugPrint('### noteCubit -> saveNote -> id: $id');
    emit(state.copyWith(needExit: true));
  }

  void _loadNoteById(String id) async {
    emit(state.copyWith(id: id, isLoading: true));
    await Future.delayed(const Duration(milliseconds: 300));
    final note = await _notesInteractor.getNoteById(id);
    titleController.text = note?.title ?? '';
    contentController.text = note?.content ?? '';
    emit(state.copyWith(isLoading: false));
    // emit(state.copyWith(title: note?.title, content: note?.content, shouldInit: true));
  }


}
