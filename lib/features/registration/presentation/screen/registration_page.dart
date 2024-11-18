import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/core/di/dependency_injection.dart';
import 'package:notes_app/core/navigation/routes/login_route.dart';
import 'package:notes_app/core/navigation/routes/profile_route.dart';
import 'package:notes_app/core/ui/widgets/text_field/login_text_fields.dart';
import 'package:notes_app/generated/l10n.dart';
import 'package:notes_app/core/utils/extensions/string_extensions.dart';

import '../bloc/registration_bloc.dart';

/**
 * Этот метод делает что-то
 * Я использую здесь...
 */
class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  ///Navigate back to specific route
  void popUntilPath(BuildContext context, String routePath) {
    final router = GoRouter.of(context);
    String currentRoute = router.routerDelegate.currentConfiguration.fullPath;
    while (currentRoute != routePath) {
      if (!context.canPop()) {
        return;
      }
      context.pop();
      currentRoute = router.routerDelegate.currentConfiguration.fullPath;
      print('currentRoute: $currentRoute');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RegistrationBloc>(),
      child: BlocListener<RegistrationBloc, RegistrationState>(
        listenWhen: (previous, current) => previous.isSuccessfullyRegistered != current.isSuccessfullyRegistered,
        listener: (context, state) {
          if (state.isSuccessfullyRegistered) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Text(S.of(context).successfully_registered),
                actions: [
                  TextButton(
                    onPressed: () {
                      popUntilPath(context, ProfileRoute.name);
                    },
                    child: Text(S.of(context).ok),
                  ),
                ],
              ),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('REGISTRATION'),
          ),
          body: const _Body(),
        ),
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
    final bloc = context.read<RegistrationBloc>();
    return BlocBuilder<RegistrationBloc, RegistrationState>(
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
            SizedBox(height: 100),
            _RegisterButton(),
          ],
        );
      },
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegistrationBloc>();
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return CustomTextField(
          errorText: state.passwordErrorText,
          labelText: S.of(context).password,
          needObscureText: true,
          onChanged: (value) => bloc.add(RegistrationPasswordChanged(password: value)),
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
    final bloc = context.read<RegistrationBloc>();
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      buildWhen: (previous, current) =>
          previous.email != current.email || previous.emailErrorText != current.emailErrorText,
      builder: (context, state) {
        return CustomTextField(
          labelText: S.of(context).email,
          errorText: state.emailErrorText,
          onChanged: (value) => bloc.add(RegistrationEmailChanged(email: value)),
        );
      },
    );
  }
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegistrationBloc>();
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      buildWhen: (prev, curr) =>
          prev.email != curr.email ||
          prev.password != curr.password ||
          prev.emailErrorText != curr.emailErrorText ||
          prev.passwordErrorText != curr.passwordErrorText,
      builder: (context, state) {
        final isEmailEmpty = state.email.isEmpty;
        final isPasswordEmpty = state.password.isEmpty;
        final hasError = state.emailErrorText != null || state.passwordErrorText != null;
        return TextButton(
          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black26)),
          onPressed: isEmailEmpty || isPasswordEmpty || hasError
              ? null
              : () {
                  bloc.add(const RegistrationRegisterButtonClicked());
                },
          child: Text(S.of(context).register),
        );
      },
    );
  }
}
