import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pomodoro_timer/auth/bloc/auth_bloc.dart';
import 'package:pomodoro_timer/helpers/constants/color_constants.dart';
import 'package:pomodoro_timer/home/bloc/home_bloc.dart';
import 'package:pomodoro_timer/create_task/view/create_task_page.dart';
import 'package:pomodoro_timer/home/widgets/task_container.dart';
import 'package:pomodoro_timer/repositories/database_repository.dart';
import 'package:pomodoro_timer/shared_models/task.dart';
import 'package:pomodoro_timer/shared_models/user.dart';

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
      listener: (context, state) {
        print(state);
      },
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
      bottomNavigationBar: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: CircleAvatar(
                  backgroundColor: kVioletBlue,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
                label: 'Create New Task',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month),
                label: 'Planner',
              ),
            ],
            onTap: (index) {
              if (index == 1) {
                Navigator.of(context).push<void>(CreateTaskPage.route());
              }
            },
          );
        },
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
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeUserDataLoadSuccess) {
                    if (state.tasks?.isEmpty ?? true) {
                      return const Expanded(
                        child: Center(
                          child: Text(
                              'You have no tasks yet. Tap the plus to add one!'),
                        ),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.tasks?.length ?? 0,
                        itemBuilder: (context, index) {
                          Task task = state.tasks![index];
                          return TaskContainer(task: task);
                        },
                      ),
                    );
                  }
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
