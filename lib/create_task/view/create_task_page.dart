import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pomodoro_timer/create_task/bloc/create_task_bloc.dart';
import 'package:pomodoro_timer/create_task/helpers/constants.dart';
import 'package:pomodoro_timer/helpers/widgets/button/elevated_button_with_error_message.dart';
import 'package:pomodoro_timer/helpers/widgets/text_field/rounded_text_field_with_error_message.dart';
import 'package:pomodoro_timer/repositories/abstract_authentication_repository.dart';
import 'package:pomodoro_timer/repositories/abstract_database_repository.dart';

class CreateTaskPage extends StatelessWidget {
  static Route<void> route() =>
      MaterialPageRoute(builder: (_) => const CreateTaskPage());

  const CreateTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateTaskBloc>(
      create: (context) => CreateTaskBloc(
        userId: context.read<AbstractAuthenticationRepository>().currentUser.id,
        databaseRepository: context.read<AbstractDatabaseRepository>(),
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
          if (state is CreateTaskInitial ||
              state is CreateTaskInProgress ||
              state is CreateTaskSubmittedFailure) {
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
                      errorCondition: !state.taskName.isValid() &&
                          (state.taskNameHasChanged ||
                              state.formSubmissionAttempted),
                      errorMessage: 'Invalid Name',
                    ),
                    SliderWithTitle(
                      text: 'Working Duration',
                      value: state.workingDuration.toDouble(),
                      minValue: kWorkingDurationMinValue,
                      maxValue: kWorkingDurationMaxValue,
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
                      minValue: kShortBreakDurationMinValue,
                      maxValue: kShortBreakDurationMaxValue,
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
                      minValue: kLongBreakDurationMinValue,
                      maxValue: kLongBreakDurationMaxValue,
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
                      errorCondition: !state.moreInfo.isValid() &&
                          (state.moreInfoHasChanged ||
                              state.formSubmissionAttempted),
                      errorMessage: 'Invalid Information',
                    ),
                    RoundedTextFieldWithErrorMessage(
                      hintText: 'Date',
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.date_range),
                        onPressed: () => showCalendarDialog(context, state),
                      ),
                      onChanged: (input) {},
                      onTap: () => print('Tap'),
                      textEditingController:
                          state.startDateTextEditingController,
                      errorCondition: false,
                      errorMessage: 'Invalid date',
                    ),
                    const Spacer(),
                    ElevatedButtonWithErrorMessage(
                      text: 'Submit Task',
                      onPress: () {
                        context.read<CreateTaskBloc>().add(
                              CreateTaskEventSubmitButtonClicked(),
                            );
                      },
                      condition: state is CreateTaskSubmittedFailure,
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

  void showCalendarDialog(BuildContext context, CreateTaskState state) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    ).then((value) {
      print(value);
      context
          .read<CreateTaskBloc>()
          .add(CreateTaskStartDateChanged(dateTime: value));
    });
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
