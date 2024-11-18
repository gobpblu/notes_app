import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notes_app/core/di/dependency_injection.dart';
import 'package:notes_app/core/utils/validation_utils.dart';
import 'package:notes_app/features/auth/domain/auth_interactor.dart';
import 'package:notes_app/features/notes/domain/models/note.dart';
import 'package:notes_app/features/notes/domain/notes_interactor.dart';
import 'package:notes_app/features/notes_list/presentation/bloc/notes_list_bloc.dart';
import 'package:notes_app/generated/l10n.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthInteractor authInteractor,
    required NotesInteractor notesInteractor,
  })  : _authInteractor = authInteractor,
        _notesInteractor = notesInteractor,
        super(const LoginState(isLoading: false)) {
    on<LoginGoogleIconClicked>(_onLoginGoogleIconClicked);
    on<LoginAppleIconClicked>(_onLoginAppleIconClicked);
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSignInButtonClicked>(_onSignInButtonClicked);
    on<LoginSaveLocalDataYesButtonClicked>(_onSaveLocalDataYesButtonClicked);
  }

  final AuthInteractor _authInteractor;
  final NotesInteractor _notesInteractor;

  void _onLoginGoogleIconClicked(
    LoginGoogleIconClicked event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final credential = await _authInteractor.getGoogleCredential();
      final userCredential = await _authInteractor.signInWithCredential(credential);
      final notes = await _notesInteractor.getLocalNotes();
      emit(state.copyWith(isSuccessfullySignedIn: true, isNotesListEmpty: notes.isEmpty));
      debugPrint('userCredential: ${userCredential.user?.email}');
    } catch (e) {
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onLoginAppleIconClicked(
    LoginAppleIconClicked event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final credential = await _authInteractor.getAppleCredential();
      final userCredential = await _authInteractor.signInWithCredential(credential);
      emit(state.copyWith(isSuccessfullySignedIn: true));
      debugPrint('userCredential: ${userCredential.user?.email}');
    } catch (e) {
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginState> emit,
  ) {
    final errorText = ValidationUtils.isValidEmail(event.email) ? null : S.current.email_error_text;
    emit(state.copyWith(email: event.email, emailErrorText: () => errorText));
    // emit(state.copyWith(emailErrorText: errorText));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final errorText = ValidationUtils.isValidPassword(event.password) ? null : S.current.password_error_text;
    emit(state.copyWith(password: event.password, passwordErrorText: () => errorText));
  }

  void _onSignInButtonClicked(
    LoginSignInButtonClicked event,
    Emitter<LoginState> emit,
  ) async {
    print('onSignInClicked => email: ${state.email}, password: ${state.password}');
    print('I WORK!!!');
    emit(state.copyWith(isLoading: true));
    final notes = await _notesInteractor.getLocalNotes();
    final userCredential = await _authInteractor.signInWith(email: state.email, password: state.password);
    if (userCredential != null) {
      debugPrint('notes: $notes');
      emit(state.copyWith(
        isLoading: false,
        isSuccessfullySignedIn: true,
        isNotesListEmpty: notes.isEmpty,
        notesList: notes,
      ));
    }
    print('USER CREDENTIAL =>>>> $userCredential');
  }

  void _onSaveLocalDataYesButtonClicked(
    LoginSaveLocalDataYesButtonClicked event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, isSuccessfullySignedIn: false));
    await _notesInteractor.saveLocalNotesToRemote(state.notesList);
    // await _notesInteractor.triggerNotesUpdate();
    getIt<NotesListBloc>().add(NotesDataLoaded());
    emit(state.copyWith(isLoading: false, isSuccessfullySignedIn: true, isNotesListEmpty: true));
  }
}
