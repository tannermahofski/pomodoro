import 'package:firebase_core/firebase_core.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_timer/auth/bloc/auth_bloc.dart';
import 'package:pomodoro_timer/firebase_options.dart';
import 'package:pomodoro_timer/helpers/theme/master_theme.dart';
import 'package:pomodoro_timer/login/bloc/login_bloc.dart';
import 'package:pomodoro_timer/repositories/auth_repository.dart';
import 'package:pomodoro_timer/routes.dart';
import 'package:pomodoro_timer/sign_up/bloc/sign_up_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final AuthRepository authRepository = AuthRepository();

  await authRepository.user.first;

  runApp(MyApp(
    authRepository: authRepository,
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepository _authRepository;
  const MyApp({super.key, required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => _authRepository,
      child: BlocProvider(
        create: (context) => AuthBloc(authRepository: _authRepository),
        child: const AppWidget(),
      ),
    );
  }
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro App',
      theme: kAppTheme,
      home: FlowBuilder<AppStatus>(
        state: context.select((AuthBloc bloc) => bloc.state.appStatus),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}
