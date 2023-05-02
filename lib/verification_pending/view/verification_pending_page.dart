import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_timer/auth/bloc/auth_bloc.dart';

class VerificationPendingPage extends StatelessWidget {
  static Page<void> page() =>
      const MaterialPage<void>(child: VerificationPendingPage());
  const VerificationPendingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.appStatus == AppStatus.authenticated) {
          context.read<AuthBloc>().add(TestUserVerified());
        }
        return const Scaffold(
          body: Center(
            child: Text('Veryify your email'),
          ),
        );
      },
    );
  }
}
