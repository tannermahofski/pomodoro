import 'package:firebase_core/firebase_core.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_timer/auth/bloc/auth_bloc.dart';
import 'package:pomodoro_timer/firebase_options.dart';
import 'package:pomodoro_timer/helpers/theme/master_theme.dart';
import 'package:pomodoro_timer/repositories/auth_repository.dart';
import 'package:pomodoro_timer/repositories/database_repository.dart';
import 'package:pomodoro_timer/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final DatabaseRepository databaseRepository = DatabaseRepository();
  final AuthRepository authRepository = AuthRepository(
    databaseRepository: databaseRepository,
  );

  await authRepository.user.first;

  runApp(
    MyApp(
      authRepository: authRepository,
      databaseRepository: databaseRepository,
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthRepository _authRepository;
  final DatabaseRepository _databaseRepository;
  const MyApp({
    super.key,
    required AuthRepository authRepository,
    required DatabaseRepository databaseRepository,
  })  : _authRepository = authRepository,
        _databaseRepository = databaseRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => _authRepository),
        RepositoryProvider(create: (context) => _databaseRepository),
      ],
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
