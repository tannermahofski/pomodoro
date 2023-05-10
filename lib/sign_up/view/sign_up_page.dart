import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:pomodoro_timer/helpers/constants/file_constants.dart';
import 'package:pomodoro_timer/helpers/widgets/button/elevated_button_with_error_message.dart';
import 'package:pomodoro_timer/helpers/widgets/form_page_container.dart';
import 'package:pomodoro_timer/helpers/widgets/text_field/rounded_text_field_with_error_message.dart';
import 'package:pomodoro_timer/repositories/abstract_authentication_repository.dart';
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
        create: (context) => SignUpBloc(
            authRepository: context.read<AbstractAuthenticationRepository>()),
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
      child: const SignUpBuilder(),
    );
  }
}

class SignUpBuilder extends StatelessWidget {
  const SignUpBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        if (state is SignUpInitial ||
            state is SignUpInProgress ||
            state is SignUpFailure) {
          return FomPageContainer(
            children: <Widget>[
              _generateBackground(context),
              _generateForm(context, state),
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
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
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * (1.5 / 5),
          ),
          Text(
            'Sign Up',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const Spacer(),
          RoundedTextFieldWithErrorMessage(
            hintText: 'Username',
            prefixIcon: const Icon(MdiIcons.account),
            obscureText: false,
            onChanged: (input) {
              context.read<SignUpBloc>().add(UsernameChanged(input));
            },
            errorCondition:
                (state.usernameHasBeenChanged && !state.username.isValid()),
            errorMessage: 'Invalid Username',
          ),
          RoundedTextFieldWithErrorMessage(
            hintText: 'Email',
            prefixIcon: const Icon(MdiIcons.email),
            obscureText: false,
            onChanged: (input) {
              context.read<SignUpBloc>().add(EmailChanged(input));
            },
            errorCondition:
                (state.emailHasBeenChanged && !state.email.isValid()),
            errorMessage: 'Invalid Email',
          ),
          RoundedTextFieldWithErrorMessage(
            hintText: 'Password',
            prefixIcon: const Icon(MdiIcons.lock),
            obscureText: true,
            onChanged: (input) {
              context.read<SignUpBloc>().add(PasswordChanged(input));
            },
            errorCondition:
                (state.passwordHasBeenChanged && !state.password.isValid()),
            errorMessage: 'Invalid Password',
          ),
          ElevatedButtonWithErrorMessage(
            text: 'Sign Up',
            onPress: () {
              context.read<SignUpBloc>().add(const FormSubmitted());
            },
            condition: state is SignUpFailure,
            errorMessage: 'Unable To Create Account',
          ),
          TextButton(
            child: const Text('Already have and account'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
