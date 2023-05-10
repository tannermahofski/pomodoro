import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:pomodoro_timer/helpers/constants/file_constants.dart';
import 'package:pomodoro_timer/helpers/widgets/button/elevated_button_with_error_message.dart';
import 'package:pomodoro_timer/helpers/widgets/form_page_container.dart';
import 'package:pomodoro_timer/helpers/widgets/text_field/rounded_text_field_with_error_message.dart';
import 'package:pomodoro_timer/login/bloc/login_bloc.dart';
import 'package:pomodoro_timer/repositories/abstract_authentication_repository.dart';
import 'package:pomodoro_timer/sign_up/view/sign_up_page.dart';

class LoginPage extends StatelessWidget {
  static Page<void> page() => const MaterialPage<void>(child: LoginPage());

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(
            authRepository: context.read<AbstractAuthenticationRepository>()),
        child: const LoginListener(),
      ),
    );
  }
}

class LoginListener extends StatelessWidget {
  const LoginListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Fluttertoast.showToast(msg: 'Failed To Login');
          //Note: In SignUpPage, we pop because FlowBuilder needs to go from the home screen.
          //Note: Here There is no need to pop here
        }
      },
      child: const LoginBuilder(),
    );
  }
}

class LoginBuilder extends StatelessWidget {
  const LoginBuilder({super.key});

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
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
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
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const Spacer(),
          RoundedTextFieldWithErrorMessage(
            hintText: 'Email',
            obscureText: false,
            prefixIcon: const Icon(MdiIcons.email),
            onChanged: (input) {
              context.read<LoginBloc>().add(EmailChanged(input));
            },
            errorCondition:
                (state.emailHasBeenChanged && !state.email.isValid()),
            errorMessage: 'Invalid Email',
          ),
          RoundedTextFieldWithErrorMessage(
            hintText: 'Password',
            obscureText: true,
            prefixIcon: const Icon(MdiIcons.lock),
            onChanged: (input) {
              context.read<LoginBloc>().add(PasswordChanged(input));
            },
            errorCondition:
                (state.passwordHasBeenChanged && !state.password.isValid()),
            errorMessage: 'Invalid Password',
          ),
          const Spacer(),
          ElevatedButtonWithErrorMessage(
            text: 'Login',
            onPress: () {
              context.read<LoginBloc>().add(const FormSubmitted());
            },
            condition: (state is LoginFailure),
            errorMessage: 'Failed To Login',
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push<void>(SignUpPage.route());
            },
            child: const Text('Don\'t have an account?'),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
