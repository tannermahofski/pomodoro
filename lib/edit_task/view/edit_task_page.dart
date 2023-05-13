import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pomodoro_timer/create_task/helpers/constants.dart';
import 'package:pomodoro_timer/create_task/view/create_task_page.dart';

import 'package:pomodoro_timer/edit_task/bloc/edit_task_bloc.dart';
import 'package:pomodoro_timer/helpers/widgets/button/elevated_button_with_error_message.dart';
import 'package:pomodoro_timer/helpers/widgets/text_field/rounded_text_field_with_error_message.dart';
import 'package:pomodoro_timer/repositories/abstract_authentication_repository.dart';
import 'package:pomodoro_timer/repositories/abstract_database_repository.dart';
import 'package:pomodoro_timer/shared_models/task.dart';

class EditTaskPage extends StatelessWidget {
  static Route<void> route(Task task) => MaterialPageRoute(
        builder: (context) => EditTaskPage(task: task),
      );

  const EditTaskPage({
    required Task task,
    super.key,
  }) : _task = task;

  final Task _task;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditTaskBloc>(
      create: (context) => EditTaskBloc(
        task: _task,
        databaseRepository: context.read<AbstractDatabaseRepository>(),
        userId: context.read<AbstractAuthenticationRepository>().currentUser.id,
      ),
      child: EditTaskListener(
        task: _task,
      ),
    );
  }
}

class EditTaskListener extends StatelessWidget {
  const EditTaskListener({
    required Task task,
    super.key,
  }) : _task = task;

  final Task _task;

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditTaskBloc, EditTaskState>(
      listener: (context, state) {
        if (state is EditTaskSubmitted) {
          Navigator.of(context).pop();
        }
      },
      child: EditTaskContainer(
        task: _task,
      ),
    );
  }
}

class EditTaskContainer extends StatelessWidget {
  const EditTaskContainer({
    required Task task,
    super.key,
  }) : _task = task;

  final Task _task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit \'${_task.name}\''),
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
                  child: IntrinsicHeight(
                    child: EditTaskBuilder(
                      task: _task,
                    ),
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

class EditTaskBuilder extends StatelessWidget {
  const EditTaskBuilder({
    required Task task,
    super.key,
  }) : _task = task;

  final Task _task;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditTaskBloc, EditTaskState>(
      builder: (context, state) {
        if (state is EditTaskInitial ||
            state is EditTaskInProgress ||
            state is EditTaskFailure) {
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
                initialValue: _task.name,
                onChanged: (input) {
                  context
                      .read<EditTaskBloc>()
                      .add(TaskNameChanged(taskName: input));
                },
                errorCondition:
                    state.taskNameHasChanged && !state.taskName.isValid(),
                errorMessage: 'Invalid Name',
              ),
              SliderWithTitle(
                text: 'Number Of Working Sessions',
                value: state.numberOfWorkingSessions,
                unit: 'Sessions',
                minValue: kNumberOfWorkingSessionsMinValue,
                maxValue: kNumberOfWorkingSessionsMaxValue,
                onChanged: (value) {
                  context.read<EditTaskBloc>().add(
                        NumberOfWorkingSessionsChanged(
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
                  context
                      .read<EditTaskBloc>()
                      .add(WorkingDurationChanged(workingDuration: value));
                },
              ),
              SliderWithTitle(
                text: 'Short Break Duration',
                value: state.shortBreakDuration,
                unit: 'Minutes',
                minValue: kShortBreakDurationMinValue,
                maxValue: kShortBreakDurationMaxValue,
                onChanged: (value) {
                  context.read<EditTaskBloc>().add(
                      ShortBreakDurationChanged(shortBreakDuration: value));
                },
              ),
              RoundedTextFieldWithErrorMessage(
                hintText: 'More Info',
                initialValue: _task.moreInfo,
                onChanged: (input) {
                  context
                      .read<EditTaskBloc>()
                      .add(MoreInfoChanged(moreInfo: input));
                },
                errorCondition: false,
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
                errorCondition: false,
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
                errorCondition: false,
                errorMessage: 'Invalid time',
              ),
              const Spacer(),
              const EditTaskFrequencyPicker(),
              const Spacer(),
              ElevatedButtonWithErrorMessage(
                text: 'Submit Task',
                onPress: () {
                  context.read<EditTaskBloc>().add(FormSubmitted());
                },
                condition: false,
                errorMessage: 'Failed to create new task',
              ),
            ],
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
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
        context.read<EditTaskBloc>().add(StartDateChanged(startDate: value));
      }
    });
  }

  void showTimeDialog(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (value != null) {
        context.read<EditTaskBloc>().add(StartTimeChanged(startTime: value));
      }
    });
  }
}

class EditTaskFrequencyPicker extends StatelessWidget {
  const EditTaskFrequencyPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditTaskBloc, EditTaskState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DayCheckboxWidget(
              day: 'S',
              value: state.sundaySelected,
              onChanged: (value) {
                context
                    .read<EditTaskBloc>()
                    .add(SundaySelected(sundaySelected: value ?? false));
              },
            ),
            DayCheckboxWidget(
              day: 'M',
              value: state.mondaySelected,
              onChanged: (value) {
                context
                    .read<EditTaskBloc>()
                    .add(MondaySelected(mondaySelected: value ?? false));
              },
            ),
            DayCheckboxWidget(
              day: 'T',
              value: state.tuesdaySelected,
              onChanged: (value) {
                context
                    .read<EditTaskBloc>()
                    .add(TuesdaySelected(tuesdaySelected: value ?? false));
              },
            ),
            DayCheckboxWidget(
              day: 'W',
              value: state.wednesdaySelected,
              onChanged: (value) {
                context
                    .read<EditTaskBloc>()
                    .add(WednesdaySelected(wednesdaySelected: value ?? false));
              },
            ),
            DayCheckboxWidget(
              day: 'Th',
              value: state.thursdaySelected,
              onChanged: (value) {
                context
                    .read<EditTaskBloc>()
                    .add(ThursdaySelected(thursdaySelected: value ?? false));
              },
            ),
            DayCheckboxWidget(
              day: 'F',
              value: state.fridaySelected,
              onChanged: (value) {
                context
                    .read<EditTaskBloc>()
                    .add(FridaySelected(fridaySelected: value ?? false));
              },
            ),
            DayCheckboxWidget(
              day: 'S',
              value: state.saturdaySelected,
              onChanged: (value) {
                context
                    .read<EditTaskBloc>()
                    .add(SaturdaySelected(saturdaySelected: value ?? false));
              },
            ),
          ],
        );
      },
    );
  }
}
