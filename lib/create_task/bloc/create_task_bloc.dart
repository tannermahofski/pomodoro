import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:pomodoro_timer/create_task/helpers/constants.dart';
import 'package:pomodoro_timer/create_task/helpers/helper_functions.dart';
import 'package:pomodoro_timer/create_task/models/more_info.dart';
import 'package:pomodoro_timer/create_task/models/task_name.dart';
import 'package:pomodoro_timer/repositories/abstract_database_repository.dart';
import 'package:pomodoro_timer/shared_models/task.dart';

part 'create_task_event.dart';
part 'create_task_state.dart';

class CreateTaskBloc extends Bloc<CreateTaskEvent, CreateTaskState> {
  CreateTaskBloc({
    required String userId,
    required AbstractDatabaseRepository databaseRepository,
  })  : _userId = userId,
        _databaseRepository = databaseRepository,
        super(
          CreateTaskInitial(
            taskName: const TaskName(''),
            numberOfWorkingSessions: kNumberOfWorkingSessionsStartingValue,
            workingDuration: kWorkingDurationStartingValue,
            longBreakDuration: kLongBreakDurationStartingValue,
            shortBreakDuration: kShortBreakDurationStartingValue,
            moreInfo: const MoreInfo(''),
            startDate: DateTime.now(),
            startDateTextEditingController: TextEditingController(
                text: DateFormat.yMd().format(DateTime.now())),
            startTime: TimeOfDay.now(),
            timeOfDayTextingEditingController:
                TextEditingController(text: getTimeText(TimeOfDay.now())),
          ),
        ) {
    on<CreateTaskEventTaskNameChanged>(
      _onCreateTaskEventTaskNameChanged,
    );
    on<CreateTaskEventNumberOfWorkingSessionsChanged>(
      _onCreateTaskEventNumberOfWorkingSessionsChanged,
    );
    on<CreateTaskEventWorkingDurationChanged>(
      _onCreateTaskEventWorkingDurationChanged,
    );
    on<CreateTaskEventLongBreakDurationChanged>(
      _onCreateTaskEventLongBreakDurationChanged,
    );
    on<CreateTaskEventShortBreakDurationChanged>(
      _onCreateTaskEventShortBreakDurationChanged,
    );
    on<CreateTaskEventSubmitButtonClicked>(
      _onCreateTaskEventSubmitButtonClicked,
    );
    on<CreateTaskEventMoreInfoChanged>(
      _onCreateTaskEventMoreInfoChanged,
    );
    on<CreateTaskStartDateChanged>(
      _onCreateTaskStartDateChanged,
    );
    on<CreateTaskTimeChanged>(
      _onCreateTaskTimeChanged,
    );
    on<CreateTaskSundaySelected>(
      _onCreateTaskSundaySelected,
    );
    on<CreateTaskMondaySelected>(
      _onCreateTaskMondaySelected,
    );
    on<CreateTaskTuesdaySelected>(
      _onCreateTaskTuesdaySelected,
    );
    on<CreateTaskWednesdaySelected>(
      _onCreateTaskWednesdaySelected,
    );
    on<CreateTaskThursdaySelected>(
      _onCreateTaskThursdaySelected,
    );
    on<CreateTaskFridaySelected>(
      _onCreateTaskFridaySelected,
    );
    on<CreateTaskSaturdaySelected>(
      _onCreateTaskSaturdaySelected,
    );
  }
  final String _userId;
  final AbstractDatabaseRepository _databaseRepository;

  @override
  Future<void> close() {
    state.startDateTextEditingController.dispose();
    state.timeOfDayTextingEditingController.dispose();
    return super.close();
  }

  void _onCreateTaskEventTaskNameChanged(
      CreateTaskEventTaskNameChanged event, Emitter<CreateTaskState> emit) {
    CreateTaskInProgress newState = CreateTaskInProgress.copyWithPreviousState(
      previousState: state,
      taskName: TaskName(event.taskName),
      taskNameHasChanged: true,
    );

    emit(newState);
  }

  void _onCreateTaskEventNumberOfWorkingSessionsChanged(
      CreateTaskEventNumberOfWorkingSessionsChanged event,
      Emitter<CreateTaskState> emit) {
    CreateTaskInProgress newState = CreateTaskInProgress.copyWithPreviousState(
      previousState: state,
      numberOfWorkingSessions: event.numberOfWorkingSessions,
    );

    emit(newState);
  }

  void _onCreateTaskEventWorkingDurationChanged(
      CreateTaskEventWorkingDurationChanged event,
      Emitter<CreateTaskState> emit) {
    CreateTaskInProgress newState = CreateTaskInProgress.copyWithPreviousState(
      previousState: state,
      workingDuration: event.workingDuration,
    );

    emit(newState);
  }

  void _onCreateTaskEventLongBreakDurationChanged(
      CreateTaskEventLongBreakDurationChanged event,
      Emitter<CreateTaskState> emit) {
    CreateTaskInProgress newState = CreateTaskInProgress.copyWithPreviousState(
      previousState: state,
      longBreakDuration: event.longBreakDuration,
    );

    emit(newState);
  }

  void _onCreateTaskEventShortBreakDurationChanged(
      CreateTaskEventShortBreakDurationChanged event,
      Emitter<CreateTaskState> emit) {
    CreateTaskInProgress newState = CreateTaskInProgress.copyWithPreviousState(
      previousState: state,
      shortBreakDuration: event.shortBreakDuration,
    );

    emit(newState);
  }

  void _onCreateTaskEventMoreInfoChanged(
      CreateTaskEventMoreInfoChanged event, Emitter<CreateTaskState> emit) {
    CreateTaskInProgress newState = CreateTaskInProgress.copyWithPreviousState(
      previousState: state,
      moreInfo: MoreInfo(event.moreInfoString),
      moreInfoHasChanged: true,
    );

    emit(newState);
  }

  void _onCreateTaskStartDateChanged(
      CreateTaskStartDateChanged event, Emitter<CreateTaskState> emit) {
    String? text;
    if (event.startDate == null) {
      return;
    }
    text = DateFormat.yMd().format(event.startDate!);

    state.startDateTextEditingController.text = text;

    CreateTaskInProgress newState = CreateTaskInProgress.copyWithPreviousState(
      previousState: state,
      startDate: event.startDate,
    );

    emit(newState);
  }

  void _onCreateTaskTimeChanged(
      CreateTaskTimeChanged event, Emitter<CreateTaskState> emit) {
    if (event.startTime == null) {
      return;
    }

    String text;

    text = getTimeText(event.startTime!);
    state.timeOfDayTextingEditingController.text = text;

    CreateTaskInProgress newState = CreateTaskInProgress.copyWithPreviousState(
      previousState: state,
      startTime: event.startTime,
    );

    emit(newState);
  }

  void _onCreateTaskSundaySelected(
      CreateTaskSundaySelected event, Emitter<CreateTaskState> emit) {
    CreateTaskInProgress newState = CreateTaskInProgress.copyWithPreviousState(
      previousState: state,
      sundaySelected: event.value,
    );

    emit(newState);
  }

  void _onCreateTaskMondaySelected(
      CreateTaskMondaySelected event, Emitter<CreateTaskState> emit) {
    CreateTaskInProgress newState = CreateTaskInProgress.copyWithPreviousState(
      previousState: state,
      mondaySelected: event.value,
    );

    emit(newState);
  }

  void _onCreateTaskTuesdaySelected(
      CreateTaskTuesdaySelected event, Emitter<CreateTaskState> emit) {
    CreateTaskInProgress newState = CreateTaskInProgress.copyWithPreviousState(
      previousState: state,
      tuesdaySelected: event.value,
    );

    emit(newState);
  }

  void _onCreateTaskWednesdaySelected(
      CreateTaskWednesdaySelected event, Emitter<CreateTaskState> emit) {
    CreateTaskInProgress newState = CreateTaskInProgress.copyWithPreviousState(
      previousState: state,
      wednesdaySelected: event.value,
    );

    emit(newState);
  }

  void _onCreateTaskThursdaySelected(
      CreateTaskThursdaySelected event, Emitter<CreateTaskState> emit) {
    CreateTaskInProgress newState = CreateTaskInProgress.copyWithPreviousState(
      previousState: state,
      thursdaySelected: event.value,
    );

    emit(newState);
  }

  void _onCreateTaskFridaySelected(
      CreateTaskFridaySelected event, Emitter<CreateTaskState> emit) {
    CreateTaskInProgress newState = CreateTaskInProgress.copyWithPreviousState(
      previousState: state,
      fridaySelected: event.value,
    );

    emit(newState);
  }

  void _onCreateTaskSaturdaySelected(
      CreateTaskSaturdaySelected event, Emitter<CreateTaskState> emit) {
    CreateTaskInProgress newState = CreateTaskInProgress.copyWithPreviousState(
      previousState: state,
      saturdaySelected: event.value,
    );

    emit(newState);
  }

  Future<void> _onCreateTaskEventSubmitButtonClicked(
      CreateTaskEventSubmitButtonClicked event,
      Emitter<CreateTaskState> emit) async {
    CreateTaskSubmitting submittingState =
        CreateTaskSubmitting.fromPreviousState(previousState: state);
    emit(submittingState);

    DateTime? newStartDate = _validateStartDate();
    TimeOfDay? newStartTime = _validateStartTime();

    submittingState = CreateTaskSubmitting.fromPreviousState(
      previousState: state,
      startTime: newStartTime,
      startDate: newStartDate,
    );

    emit(submittingState);

    bool valid = _validateAllFields();

    if (!valid) {
      CreateTaskSubmittedFailure failureState =
          CreateTaskSubmittedFailure.copyFromPreviousState(state);
      emit(failureState);
      return;
    }

    Task task = Task(
      name: state.taskName.value,
      numberOfWorkingSessions: state.numberOfWorkingSessions.toInt(),
      workingDuration: state.workingDuration.toInt(),
      shortBreakDuration: state.shortBreakDuration.toInt(),
      longBreakDuration: state.longBreakDuration.toInt(),
      moreInfo: state.moreInfo.value,
      startDate: state.startDate,
      startTime: state.startTime,
      recurrenceRule: _generateRecurrenceRule(),
      currentStatus: CurrentStatus(
          workingStatus: WorkingStatus.notStarted, date: DateTime.now()),
    );

    try {
      await _databaseRepository.addTaskToUser(
        userId: _userId,
        task: task,
      );

      CreateTaskSubmittedSuccesfully successState =
          CreateTaskSubmittedSuccesfully.copyFromPreviousState(state);
      emit(successState);
    } on Exception catch (_) {
      CreateTaskSubmittedFailure failureState =
          CreateTaskSubmittedFailure.copyFromPreviousState(state);
      emit(failureState);
    }
  }

  DateTime? _validateStartDate() {
    if (state.startDate == null &&
        state.startDateTextEditingController.text.length > 4) {
      // month/day/year
      // Switch to
      // year-month-day

      String dateString = state.startDateTextEditingController.text;
      List<String> split = dateString.split('/');

      String year = split[2];
      String day = split[1];
      String month = split[0];

      if (day.length <= 1) {
        day = '0$day';
      }

      if (month.length <= 1) {
        month = '0$month';
      }

      String newDate = [year, month, day].join('-');

      DateTime? startDate = DateTime.tryParse(newDate);
      return startDate;
    }
    return null;
  }

  TimeOfDay? _validateStartTime() {
    if (state.startTime == null &&
        state.timeOfDayTextingEditingController.text.length > 4) {
      String startTimeString = state.timeOfDayTextingEditingController.text;
      List<String> split = startTimeString.split(':');

      int? hours = int.tryParse(split[0]);
      List<String> split2 = split[1].split(' ');
      int? minutes = int.tryParse(split2[0]);

      if (split2[1] == 'PM' && hours != null) {
        hours += 12;
      }

      if (hours != null && minutes != null) {
        TimeOfDay startTime = TimeOfDay(hour: hours, minute: minutes);

        return startTime;
      }
    }

    return null;
  }

  bool _validateAllFields() {
    if (!state.taskName.isValid() ||
        !state.moreInfo.isValid() ||
        state.startDateTextEditingController.text.isEmpty ||
        state.timeOfDayTextingEditingController.text.isEmpty ||
        state.startDate == null ||
        state.startTime == null) {
      return false;
    }
    return true;
  }

  String? _generateRecurrenceRule() {
    String? recurrenceRule;

    if (state.sundaySelected ||
        state.mondaySelected ||
        state.tuesdaySelected ||
        state.wednesdaySelected ||
        state.thursdaySelected ||
        state.fridaySelected ||
        state.saturdaySelected) {
      recurrenceRule = 'FREQ=WEEKLY;';
      recurrenceRule += 'BYDAY=';
      if (state.sundaySelected) recurrenceRule += 'SU,';
      if (state.mondaySelected) recurrenceRule += 'MO,';
      if (state.tuesdaySelected) recurrenceRule += 'TU,';
      if (state.wednesdaySelected) recurrenceRule += 'WE,';
      if (state.thursdaySelected) recurrenceRule += 'TH,';
      if (state.fridaySelected) recurrenceRule += 'FR,';
      if (state.saturdaySelected) recurrenceRule += 'SA,';

      List<String> split = recurrenceRule.split('');
      split.removeLast();
      recurrenceRule = split.join();
    }

    return recurrenceRule;
  }
}
