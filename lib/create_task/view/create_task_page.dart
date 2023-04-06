import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_timer/create_task/bloc/create_task_bloc.dart';
import 'package:pomodoro_timer/helpers/widgets/button/elevated_button_with_error_message.dart';
import 'package:pomodoro_timer/helpers/widgets/text_field/rounded_text_field_with_error_message.dart';
import 'package:pomodoro_timer/repositories/auth_repository.dart';
import 'package:pomodoro_timer/repositories/database_repository.dart';

class CreateTaskPage extends StatelessWidget {
  static Route<void> route() =>
      MaterialPageRoute(builder: (_) => const CreateTaskPage());

  const CreateTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateTaskBloc>(
      create: (context) => CreateTaskBloc(
        userId: context.read<AuthRepository>().currentUser.id,
        databaseRepository: context.read<DatabaseRepository>(),
      ),
      child: const CreateTaskPageListener(),
    );
  }
}

class CreateTaskPageListener extends StatelessWidget {
  const CreateTaskPageListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateTaskBloc, CreateTaskState>(
      listener: (context, state) {
        if (state is CreateTaskSubmittedSuccesfully) {
          Navigator.of(context).pop();
        }
      },
      child: const CreateTaskPageContainer(),
    );
  }
}

class CreateTaskPageContainer extends StatelessWidget {
  const CreateTaskPageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Task'),
      ),
      body: BlocBuilder<CreateTaskBloc, CreateTaskState>(
        builder: (context, state) {
          if (state is CreateTaskInitial || state is CreateTaskInProgress) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Task Name',
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    RoundedTextFieldWithErrorMessage(
                      hintText: 'Task Name',
                      onChanged: (input) {
                        context.read<CreateTaskBloc>().add(
                              CreateTaskEventTaskNameChanged(
                                taskName: input,
                              ),
                            );
                      },
                      condition:
                          !state.taskName.isValid() && state.taskNameHasChanged,
                      errorMessage: 'Invalid Name',
                    ),
                    SliderWithTitle(
                      text: 'Working Duration',
                      value: state.workingDuration.toDouble(),
                      minValue: 5.0,
                      maxValue: 60.0,
                      onChanged: (value) {
                        context.read<CreateTaskBloc>().add(
                              CreateTaskEventWorkingDurationChanged(
                                workingDuration: value,
                              ),
                            );
                      },
                    ),
                    SliderWithTitle(
                      text: 'Short Break Duration',
                      value: state.shortBreakDuration.toDouble(),
                      minValue: 3.0,
                      maxValue: 10.0,
                      onChanged: (value) {
                        context.read<CreateTaskBloc>().add(
                              CreateTaskEventShortBreakDurationChanged(
                                shortBreakDuration: value,
                              ),
                            );
                      },
                    ),
                    SliderWithTitle(
                      text: 'Long Break Duration',
                      value: state.longBreakDuration.toDouble(),
                      minValue: 5.0,
                      maxValue: 15.0,
                      onChanged: (value) {
                        context.read<CreateTaskBloc>().add(
                              CreateTaskEventLongBreakDurationChanged(
                                longBreakDuration: value,
                              ),
                            );
                      },
                    ),
                    RoundedTextFieldWithErrorMessage(
                      hintText: 'More Info',
                      onChanged: (input) {
                        context.read<CreateTaskBloc>().add(
                              CreateTaskEventMoreInfoChanged(
                                moreInfoString: input,
                              ),
                            );
                      },
                      condition:
                          !state.moreInfo.isValid() && state.moreInfoHasChanged,
                      errorMessage: 'Invalid Information',
                    ),
                    const Spacer(),
                    ElevatedButtonWithErrorMessage(
                      text: 'Submit Task',
                      onPress: () {
                        context.read<CreateTaskBloc>().add(
                              CreateTaskEventSubmitButtonClicked(),
                            );
                      },
                      condition: false,
                      errorMessage: 'Failed to create new task',
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class SliderWithTitle extends StatelessWidget {
  const SliderWithTitle({
    required this.text,
    required this.value,
    required this.minValue,
    required this.maxValue,
    required this.onChanged,
    super.key,
  });

  final String text;
  final double value;
  final double minValue;
  final double maxValue;
  final Function(double) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          text,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Row(
          children: <Widget>[
            Text('${value.toString()} Mins'),
            Expanded(
              child: Slider(
                value: value,
                label: value.toString(),
                divisions: (maxValue - minValue).toInt(),
                min: minValue,
                max: maxValue,
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
