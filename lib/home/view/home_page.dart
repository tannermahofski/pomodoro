import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_timer/auth/bloc/auth_bloc.dart';
import 'package:pomodoro_timer/edit_task/view/edit_task_page.dart';
import 'package:pomodoro_timer/helpers/constants/color_constants.dart';
import 'package:pomodoro_timer/home/bloc/home_bloc.dart';
import 'package:pomodoro_timer/home/widgets/task_container.dart';
import 'package:pomodoro_timer/pomodoro/view/pomodoro_page.dart';
import 'package:pomodoro_timer/repositories/abstract_database_repository.dart';
import 'package:pomodoro_timer/shared_models/task.dart';
import 'package:pomodoro_timer/shared_models/user.dart';

class HomePage extends StatelessWidget {
  static Route<void> route() =>
      MaterialPageRoute(builder: (context) => const HomePage());
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        return BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(
            databaseRepository: context.read<AbstractDatabaseRepository>(),
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
      child: HomeBuilder(user: user),
    );
  }
}

class HomeBuilder extends StatelessWidget {
  const HomeBuilder({required this.user, super.key});

  final User user;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            List<Widget> children = [];
            if (state is HomeLoadDataSuccess) {
              children.add(
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '${state.saying}, ${user.username}',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontSize: 30),
                  ),
                ),
              );

              if (state.tasks?.isEmpty ?? true) {
                children.add(
                  const Expanded(
                    child: Center(
                      child: Text(
                        'You have no tasks yet. Tap the plus to add one!',
                      ),
                    ),
                  ),
                );
              } else {
                List<Task> tasksToDo = [];
                List<Task> tasksCompleted = [];

                for (Task task in state.tasks ?? []) {
                  if (task.shouldCompleteToday()) {
                    if (task.currentStatus.workingStatus ==
                        WorkingStatus.completed) {
                      tasksCompleted.add(task);
                    } else {
                      tasksToDo.add(task);
                    }
                  }
                }

                children.addAll(
                  [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        'To Do Today:',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    tasksToDo.isNotEmpty
                        ? _generateListOfTasks(tasksToDo, context)
                        : const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Center(
                              child: Text(
                                'You\'ve completed all your tasks for the day!',
                              ),
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        'Completed:',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    tasksCompleted.isNotEmpty
                        ? _generateListOfTasks(tasksCompleted, context)
                        : const Center(
                            child: Text(
                              'Look at the tasks you have to do today!',
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        'All Tasks:',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    state.tasks!.isNotEmpty
                        ? _generateListOfTasks(state.tasks!, context)
                        : Container(),
                  ],
                );
              }
            } else {
              children.add(
                const Flexible(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }

            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: children,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _generateListOfTasks(List<Task> tasks, BuildContext context) {
    double height = tasks.length >= 2 ? 250 : 125;
    return Material(
      elevation: 5,
      color: kLightYellow,
      shadowColor: Colors.black,
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        height: height,
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            Task task = tasks[index];
            return TaskContainer(
              task: task,
              onTap: () {
                Navigator.of(context).push(
                  PomodoroPage.route(task),
                );
              },
              onLongPress: () {
                showDeletionDialog(task, context);
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> showDeletionDialog(Task task, BuildContext context) async {
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.error,
      headerAnimationLoop: false,
      body: const Center(
        child: Text('You have completed the task!'),
      ),
      btnOkText: 'Remove',
      btnOkColor: Colors.red,
      btnOkIcon: Icons.close,
      btnOkOnPress: () {
        context.read<HomeBloc>().add(
              HomeTaskRemoved(task: task),
            );
      },
      btnCancelText: 'Edit',
      btnCancelColor: Colors.green,
      btnCancelIcon: Icons.edit,
      btnCancelOnPress: () {
        Navigator.of(context).push(EditTaskPage.route(task));
      },
    ).show();
  }
}
