import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pomodoro_timer/helpers/constants/file_constants.dart';
import 'package:pomodoro_timer/helpers/widgets/form_page_container.dart';
import 'package:pomodoro_timer/helpers/widgets/login_page_button.dart';
import 'package:pomodoro_timer/helpers/widgets/login_page_text_field.dart';
import 'package:pomodoro_timer/login/bloc/login_bloc.dart';
import 'package:pomodoro_timer/repositories/auth_repository.dart';
import 'package:pomodoro_timer/sign_up/view/sign_up_page.dart';

class LoginPage extends StatelessWidget {
  static Page<void> page() => const MaterialPage<void>(child: LoginPage());

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) =>
            LoginBloc(authRepository: context.read<AuthRepository>()),
        child: const LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          //Note: Show toast here
        }
      },
      child: const LoginFormContainer(),
    );
  }
}

class LoginFormContainer extends StatelessWidget {
  const LoginFormContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginInitial ||
            state is LoginInProgress ||
            state is LoginFailure) {
          return FomPageContainer(
            children: [
              _generateBackground(context),
              _generateForm(context, state),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _generateBackground(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * (2 / 5),
      child: SvgPicture.asset(kTimeManagementSvg),
    );
  }

  Widget _generateForm(BuildContext context, LoginState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * (1.75 / 5),
          ),
          Text(
            'Welcome',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * (1 / 25)),
          LoginPageTextField(
            hintText: 'Email',
            onChanged: (input) {
              context.read<LoginBloc>().add(UsernameChanged(input));
            },
          ),
          Opacity(
            opacity:
                (!state.email.isValid() && state.emailHasBeenChanged) ? 1 : 0,
            child: Text(
              'Invalid email',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          LoginPageTextField(
            hintText: 'Password',
            obscureText: true,
            onChanged: (input) {
              context.read<LoginBloc>().add(PasswordChanged(input));
            },
          ),
          Opacity(
            opacity: (!state.password.isValid() && state.passwordHasBeenChanged)
                ? 1
                : 0,
            child: Text(
              'Invalid password',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          const Expanded(
            child: SizedBox(),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Opacity(
                opacity: (state is LoginFailure) ? 1 : 0,
                child: Text(
                  'Failed To Login',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
          ),
          LoginPageButton(
            text: 'Login',
            onPress: () {
              context.read<LoginBloc>().add(const FormSubmitted());
            },
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push<void>(SignUpPage.route());
            },
            child: const Text('Don\'t have an account?'),
          ),
          const Expanded(
            child: SizedBox(),
          )
        ],
      ),
    );
  }
}
