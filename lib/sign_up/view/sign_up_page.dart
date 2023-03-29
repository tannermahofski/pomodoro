import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pomodoro_timer/helpers/constants/file_constants.dart';
import 'package:pomodoro_timer/helpers/widgets/form_page_container.dart';
import 'package:pomodoro_timer/helpers/widgets/login_page_button.dart';
import 'package:pomodoro_timer/helpers/widgets/login_page_text_field.dart';
import 'package:pomodoro_timer/repositories/auth_repository.dart';
import 'package:pomodoro_timer/sign_up/bloc/sign_up_bloc.dart';

class SignUpPage extends StatelessWidget {
  static Route<void> route() {
    return MaterialPageRoute(builder: (_) => const SignUpPage());
  }

  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<SignUpBloc>(
        create: (context) =>
            SignUpBloc(authRepository: context.read<AuthRepository>()),
        child: const SignUpForm(),
      ),
    );
  }
}

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpDone) {
          Navigator.of(context).pop();
        }
      },
      child: const SignUpFormContainer(),
    );
  }
}

class SignUpFormContainer extends StatelessWidget {
  const SignUpFormContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return FomPageContainer(
          children: <Widget>[
            _generateBackground(context),
            _generateForm(context, state),
          ],
        );
      },
    );
  }

  Widget _generateBackground(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * (1.5 / 5),
      width: MediaQuery.of(context).size.height * (2 / 5),
      child: Align(
        alignment: Alignment.topLeft,
        child: SvgPicture.asset(kDevProductivitySvg),
      ),
    );
  }

  Widget _generateForm(BuildContext context, SignUpState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * (1.5 / 5),
          ),
          Text(
            'Sign Up',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * (1 / 25)),
          LoginPageTextField(
            hintText: 'Username',
            onChanged: (input) {
              context.read<SignUpBloc>().add(UsernameChanged(input));
            },
          ),
          Opacity(
            opacity: (state.usernameHasBeenChanged && !state.username.isValid())
                ? 1
                : 0,
            child: Text(
              'Invalid username',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          LoginPageTextField(
            hintText: 'Email',
            onChanged: (input) {
              context.read<SignUpBloc>().add(EmailChanged(input));
            },
          ),
          Opacity(
            opacity:
                (state.emailHasBeenChanged && !state.email.isValid()) ? 1 : 0,
            child: Text(
              'Invalid email',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          LoginPageTextField(
            hintText: 'Password',
            obscureText: true,
            onChanged: (input) {
              context.read<SignUpBloc>().add(PasswordChanged(input));
            },
          ),
          Opacity(
            opacity: (state.passwordHasBeenChanged && !state.password.isValid())
                ? 1
                : 0,
            child: Text(
              'Invalid password',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          const Expanded(child: SizedBox()),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Opacity(
                opacity: (state is SignUpFailure) ? 1 : 0,
                child: Text(
                  'Unable to create account',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
          ),
          LoginPageButton(
            text: 'Sign Up',
            onPress: () {
              context.read<SignUpBloc>().add(const FormSubmitted());
            },
          ),
          TextButton(
            child: const Text('Already have and account'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
