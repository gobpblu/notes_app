import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/core/di/dependency_injection.dart';
import 'package:notes_app/core/navigation/routes/registration_route.dart';
import 'package:notes_app/core/ui/widgets/text_field/login_text_fields.dart';
import 'package:notes_app/features/login/presentation/bloc/login_bloc.dart';
import 'package:notes_app/generated/l10n.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginBloc>(),
      child: const _LoginScreen(),
    );
  }
}

class _LoginScreen extends StatelessWidget {
  const _LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) =>
      previous.isSuccessfullySignedIn != current.isSuccessfullySignedIn ||
          previous.isNotesListEmpty != current.isNotesListEmpty,
      listener: (context, state) {
        if (state.isSuccessfullySignedIn) {
          if (state.isNotesListEmpty) {
            context.pop();
          } else {
            showDialog(context: context, builder: (context) => _SaveLocalDataDialog(bloc: bloc));
            // context.pop();
          }
        }
      },
      child: Scaffold(
        // extendBody: true,
        // persistentFooterButtons: [
        //   _RegisterButton(),
        // ],
        resizeToAvoidBottomInset: true,
        persistentFooterAlignment: AlignmentDirectional.bottomCenter,
        appBar: AppBar(
          title: Text('LOGIN'),
        ),
        body: const _Body(),
      ),
    );
  }
}


class _Body extends StatelessWidget {
  const _Body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.isLoading != current.isLoading,
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: _EmailField(),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: _PasswordField(),
            ),
            SizedBox(height: 40),
            _SignInButton(),
            SizedBox(height: 8),
            _RegisterButton(),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _GoogleIcon(),
                _AppleButton(),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _GoogleIcon extends StatelessWidget {
  const _GoogleIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();
    return IconButton(
      onPressed: () {
        bloc.add(LoginGoogleIconClicked());
      },
      icon: SvgPicture.asset('assets/icons/ic_play_market.svg'),
    );
  }
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          context.go(RegistrationRoute.navigateRoute);
        },
        child: Text(S.of(context).register));
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return CustomTextField(
          errorText: state.passwordErrorText,
          labelText: S.of(context).password,
          onChanged: (value) => bloc.add(LoginPasswordChanged(password: value)),
          needObscureText: true,
        );
      },
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
          previous.email != current.email || previous.emailErrorText != current.emailErrorText,
      builder: (context, state) {
        return CustomTextField(
          labelText: S.of(context).email,
          errorText: state.emailErrorText,
          onChanged: (value) => bloc.add(LoginEmailChanged(email: value)),
        );
      },
    );
  }
}

class _SignInButton extends StatelessWidget {
  const _SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (prev, curr) =>
          prev.email != curr.email ||
          prev.password != curr.password ||
          prev.emailErrorText != curr.emailErrorText ||
          prev.passwordErrorText != curr.passwordErrorText,
      builder: (context, state) {
        final isEmailEmpty = state.email.isEmpty;
        final isPasswordEmpty = state.password.isEmpty;
        final hasError = state.emailErrorText != null || state.passwordErrorText != null;
        return ElevatedButton(
          onPressed: isEmailEmpty || isPasswordEmpty || hasError
              ? null
              : () {
                  bloc.add(LoginSignInButtonClicked());
                },
          child: Text(S.of(context).sign_in),
        );
      },
    );
  }
}

class _AppleButton extends StatelessWidget {
  const _AppleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();
    if (!Platform.isIOS) return const SizedBox();
    return IconButton(
      onPressed: () async {
        bloc.add(LoginAppleIconClicked());
      },
      icon: Icon(Icons.apple),
    );
  }
}

class _SaveLocalDataDialog extends StatelessWidget {
  const _SaveLocalDataDialog({super.key, required this.bloc});

  final LoginBloc bloc;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).save_local_data_title),
      content: Text(S.of(context).save_local_data_description),
      actions: [
        TextButton(
          child: Text(S.of(context).button_yes),
          onPressed: () {
            context.pop();
            bloc.add(LoginSaveLocalDataYesButtonClicked());
          },
        ),
        TextButton(
          child: Text(S.of(context).button_no),
          onPressed: () {
            context.pop();
            context.pop();
          },
        ),
      ],
    );
  }
}
