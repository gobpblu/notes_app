part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool isLoading;
  final String email;
  final String password;
  final String? emailErrorText;
  final String? passwordErrorText;
  final bool isSuccessfullySignedIn;
  final bool isNotesListEmpty;
  final List<Note> notesList;

  const LoginState({
    required this.isLoading,
    this.isSuccessfullySignedIn = false,
    this.isNotesListEmpty = false,
    this.email = "",
    this.password = "",
    this.emailErrorText,
    this.passwordErrorText,
    this.notesList = const [],
  });

  LoginState copyWith({
    bool? isLoading,
    bool? isSuccessfullySignedIn,
    bool? isNotesListEmpty,
    String? email,
    String? password,
    String? Function()? emailErrorText,
    String? Function()? passwordErrorText,
    List<Note>? notesList,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isSuccessfullySignedIn: isSuccessfullySignedIn ?? this.isSuccessfullySignedIn,
      isNotesListEmpty: isNotesListEmpty ?? this.isNotesListEmpty,
      email: email ?? this.email,
      password: password ?? this.password,
      emailErrorText: emailErrorText != null ? emailErrorText() : this.emailErrorText,
      passwordErrorText: passwordErrorText != null ? passwordErrorText() : this.passwordErrorText,
      notesList: notesList ?? this.notesList,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSuccessfullySignedIn,
        isNotesListEmpty,
        email,
        password,
        emailErrorText,
        passwordErrorText,
        notesList,
      ];
}
