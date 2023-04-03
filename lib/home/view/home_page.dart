import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pomodoro_timer/auth/bloc/auth_bloc.dart';
import 'package:pomodoro_timer/home/bloc/home_bloc.dart';
import 'package:pomodoro_timer/home/view/create_task_page.dart';
import 'package:pomodoro_timer/home/widgets/task_container.dart';
import 'package:pomodoro_timer/repositories/database_repository.dart';
import 'package:pomodoro_timer/shared_models/task.dart';
import 'package:pomodoro_timer/shared_models/user.dart';

final List<Task> sampleTasks = [
  const Task(
    name: 'App Development',
    duration: '25 Mins',
    moreInfo: 'Extra Info',
    icon: Icon(Icons.computer),
  ),
  const Task(
    name: 'Reading',
    duration: '25 Mins',
    moreInfo: 'Extra Info',
    icon: Icon(Icons.book_rounded),
  ),
  const Task(
    name: 'YouTube',
    duration: '25 Mins',
    moreInfo: 'Extra Info',
    icon: Icon(MdiIcons.youtubeStudio),
  ),
  const Task(
    name: 'Bible Study',
    duration: '25 Mins',
    moreInfo: 'Extra Info',
    icon: Icon(MdiIcons.crown),
  )
];

class HomePage extends StatelessWidget {
  static Page<void> page() => const MaterialPage<void>(child: HomePage());
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        return BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(
            databaseRepository: context.read<DatabaseRepository>(),
            userId: authState.user.id,
          ),
          child: HomeListener(
            user: authState.user,
          ),
        );
      },
    );
  }
}

class HomeListener extends StatelessWidget {
  const HomeListener({
    required this.user,
    super.key,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {},
      child: HomeContainer(user: user),
    );
  }
}

class HomeContainer extends StatelessWidget {
  const HomeContainer({
    required this.user,
    super.key,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeUserDataLoadSuccess) {
          return Scaffold(
            appBar: AppBar(
              leading: const Icon(MdiIcons.clockOutline),
              title: const Text('Task Mastr'),
              actions: [
                IconButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(LogoutRequested());
                  },
                  icon: const Icon(
                    Icons.logout_rounded,
                  ),
                )
              ],
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Good Morning, ${user.username}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.tasks?.length ?? 0,
                        itemBuilder: (context, index) {
                          Task task = state.tasks![index];
                          return TaskContainer(task: task);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // Navigator.of(context).push<void>(CreateTaskPage.route());
                context.read<HomeBloc>().add(
                      HomeAddNewTaskButtonPressed(userId: user.id),
                    );
              },
              child: const Icon(Icons.add),
            ),
          );
        }
        //Note: if in any other states
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
