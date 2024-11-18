part of 'notes_list_bloc.dart';

class NotesListState extends Equatable {
  final List<Note> notes;
  final String? currentAction;
  final bool isLoading;

  const NotesListState({
    required this.notes,
    this.currentAction,
    this.isLoading = false,
  });

  NotesListState copyWith({
    List<Note>? notes,
    String? currentAction,
    bool? isLoading,
  }) {
    return NotesListState(
      notes: notes ?? this.notes,
      currentAction: currentAction ?? this.currentAction,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [notes, currentAction, isLoading];
}
