import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_timer/auth/bloc/auth_bloc.dart';

class HomePage extends StatelessWidget {
  static const String route = '/home';
  static Page<void> page() => const MaterialPage<void>(child: HomePage());
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Center(
            child: TextButton(
              child: Text('Logout'),
              onPressed: () {
                context.read<AuthBloc>().add(LogoutRequested());
              },
            ),
          );
        },
      ),
    );
  }
}
