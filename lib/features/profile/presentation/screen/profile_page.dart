import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/core/di/dependency_injection.dart';
import 'package:notes_app/core/navigation/routes/login_route.dart';
import 'package:notes_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:notes_app/generated/l10n.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      getIt<ProfileBloc>()
        ..add(ProfileUserSubscribed())..add(ProfileCurrentUserLoaded()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('PROFILE'),
          actions: [_SignOutButton()],
        ),
        body: _Body(),
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
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        final user = state.user;
        final isLoading = state.isLoading;
        if (isLoading) return const Center(child: CircularProgressIndicator());
        if (user == null) return const _AuthorizeButton();
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _ProfileImage(),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _EmailText(),
                      _UsernameText(),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _AuthorizeButton extends StatelessWidget {
  const _AuthorizeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          context.go(LoginRoute.navigateRoute);
        },
        child: Text(S
            .of(context)
            .login),
      ),
    );
  }
}

class _ProfileImage extends StatelessWidget {
  const _ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        final user = state.user;
        if (user == null) return SvgPicture.asset('assets/icons/ic_user_question.svg');
        final imageLink = user.photoURL;
        if (imageLink == null) return SvgPicture.asset('assets/icons/ic_user.svg');
        debugPrint('imageLink: $imageLink');
        return Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            image: DecorationImage(
              image: NetworkImage(imageLink),
            ),
          ),
        );
      },
    );
  }
}

class _EmailText extends StatelessWidget {
  const _EmailText({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        final email = state.user?.email;
        if (email == null) return const SizedBox();
        return Text(email);
      },
    );
  }
}

class _UsernameText extends StatelessWidget {
  const _UsernameText({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        final username = state.user?.displayName;
        if (username == null) return const SizedBox();
        return Text(username);
      },
    );
  }
}

class _SignOutButton extends StatelessWidget {
  const _SignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileBloc>();
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state.user == null) return const SizedBox();
        return IconButton(
          onPressed: () {
            bloc.add(ProfileLogOutButtonClicked());
          },
          icon: const Icon(Icons.exit_to_app),
        );
      },
    );
  }
}
