import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: constraints.maxWidth,
                    minHeight: constraints.maxHeight,
                  ),
                  child: const IntrinsicHeight(
                    child: CreateTaskForm(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CreateTaskForm extends StatelessWidget {
  const CreateTaskForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTaskBloc, CreateTaskState>(
      builder: (context, state) {
        if (state is CreateTaskInitial ||
            state is CreateTaskInProgress ||
            state is CreateTaskSubmittedFailure) {
          return Column(
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
                    (state.taskNameHasChanged || state.formSubmissionAttempted),
                errorMessage: 'Invalid Name',
              ),
              SliderWithTitle(
                text: 'Number Of Working Sessions',
                value: state.numberOfWorkingSessions,
                unit: 'Sessions',
                minValue: kNumberOfWorkingSessionsMinValue,
                maxValue: kNumberOfWorkingSessionsMaxValue,
                onChanged: (value) {
                  context.read<CreateTaskBloc>().add(
                        CreateTaskEventNumberOfWorkingSessionsChanged(
                          numberOfWorkingSessions: value,
                        ),
                      );
                },
              ),
              SliderWithTitle(
                text: 'Working Duration',
                value: state.workingDuration,
                unit: 'Minutes',
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
                value: state.shortBreakDuration,
                unit: 'Minutes',
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
                value: state.longBreakDuration,
                unit: 'Minutes',
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
                    (state.moreInfoHasChanged || state.formSubmissionAttempted),
                errorMessage: 'Invalid Information',
              ),
              RoundedTextFieldWithErrorMessage(
                hintText: 'Start Date',
                prefixIcon: IconButton(
                  icon: const Icon(Icons.date_range),
                  onPressed: () => showCalendarDialog(context),
                ),
                onChanged: (input) {},
                onTap: () => showCalendarDialog(context),
                readOnly: true,
                textEditingController: state.startDateTextEditingController,
                errorCondition:
                    state.formSubmissionAttempted && state.startDate == null,
                errorMessage: 'Invalid date',
              ),
              RoundedTextFieldWithErrorMessage(
                hintText: 'Start Time',
                prefixIcon: IconButton(
                  icon: const Icon(MdiIcons.clock),
                  onPressed: () => showTimeDialog(context),
                ),
                onChanged: (input) {},
                onTap: () => showTimeDialog(context),
                readOnly: true,
                textEditingController: state.timeOfDayTextingEditingController,
                errorCondition:
                    state.formSubmissionAttempted && state.startTime == null,
                errorMessage: 'Invalid time',
              ),
              const Spacer(),
              const FrequencyPicker(),
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
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  void showCalendarDialog(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    ).then((value) {
      if (value != null) {
        context
            .read<CreateTaskBloc>()
            .add(CreateTaskStartDateChanged(dateTime: value));
      }
    });
  }

  void showTimeDialog(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (value != null) {
        context
            .read<CreateTaskBloc>()
            .add(CreateTaskTimeChanged(startTime: value));
      }
    });
  }
}

class FrequencyPicker extends StatelessWidget {
  const FrequencyPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTaskBloc, CreateTaskState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DayCheckboxWidget(
              day: 'S',
              value: state.sundaySelected,
              onChanged: (value) {
                context
                    .read<CreateTaskBloc>()
                    .add(CreateTaskSundaySelected(value: value));
              },
            ),
            DayCheckboxWidget(
              day: 'M',
              value: state.mondaySelected,
              onChanged: (value) {
                context
                    .read<CreateTaskBloc>()
                    .add(CreateTaskMondaySelected(value: value));
              },
            ),
            DayCheckboxWidget(
              day: 'T',
              value: state.tuesdaySelected,
              onChanged: (value) {
                context
                    .read<CreateTaskBloc>()
                    .add(CreateTaskTuesdaySelected(value: value));
              },
            ),
            DayCheckboxWidget(
              day: 'W',
              value: state.wednesdaySelected,
              onChanged: (value) {
                context
                    .read<CreateTaskBloc>()
                    .add(CreateTaskWednesdaySelected(value: value));
              },
            ),
            DayCheckboxWidget(
              day: 'Th',
              value: state.thursdaySelected,
              onChanged: (value) {
                context
                    .read<CreateTaskBloc>()
                    .add(CreateTaskThursdaySelected(value: value));
              },
            ),
            DayCheckboxWidget(
              day: 'F',
              value: state.fridaySelected,
              onChanged: (value) {
                context
                    .read<CreateTaskBloc>()
                    .add(CreateTaskFridaySelected(value: value));
              },
            ),
            DayCheckboxWidget(
              day: 'S',
              value: state.saturdaySelected,
              onChanged: (value) {
                context
                    .read<CreateTaskBloc>()
                    .add(CreateTaskSaturdaySelected(value: value));
              },
            ),
          ],
        );
      },
    );
  }
}

class DayCheckboxWidget extends StatelessWidget {
  const DayCheckboxWidget({
    required this.day,
    required this.value,
    required this.onChanged,
    super.key,
  });

  final String day;
  final bool value;
  final Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(day),
        Checkbox(
          value: value,
          onChanged: onChanged,
        )
      ],
    );
  }
}

class SliderWithTitle extends StatelessWidget {
  const SliderWithTitle({
    required this.text,
    required this.value,
    required this.unit,
    required this.minValue,
    required this.maxValue,
    required this.onChanged,
    super.key,
  });

  final String text;
  final double value;
  final String unit;
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
            Text('${value.toInt().toString()} $unit'.trim()),
            Expanded(
              child: Slider(
                value: value,
                label: value.toInt().toString(),
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
