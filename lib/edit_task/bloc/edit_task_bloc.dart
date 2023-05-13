import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:pomodoro_timer/create_task/helpers/helper_functions.dart';
import 'package:pomodoro_timer/create_task/models/more_info.dart';
import 'package:pomodoro_timer/create_task/models/task_name.dart';
import 'package:pomodoro_timer/repositories/abstract_database_repository.dart';
import 'package:pomodoro_timer/shared_models/task.dart';

part 'edit_task_event.dart';
part 'edit_task_state.dart';

class EditTaskBloc extends Bloc<EditTaskEvent, EditTaskState> {
  EditTaskBloc({
    required Task task,
    required AbstractDatabaseRepository databaseRepository,
    required String userId,
  })  : _task = task,
        _databaseRepository = databaseRepository,
        _userId = userId,
        super(
          EditTaskInitial(
            taskName: TaskName(task.name),
            numberOfWorkingSessions: task.numberOfWorkingSessions.toDouble(),
            workingDuration: task.workingDuration.toDouble(),
            shortBreakDuration: task.shortBreakDuration.toDouble(),
            moreInfo: MoreInfo(task.moreInfo),
            startDate: task.startDate!,
            startDateTextEditingController: TextEditingController(
              text: DateFormat.yMd().format(task.startDate!),
            ),
            startTime: task.startTime!,
            timeOfDayTextingEditingController: TextEditingController(
              text: getTimeText(task.startTime!),
            ),
            sundaySelected: task.recurrenceRule?.contains('SU,') ?? false,
            mondaySelected: task.recurrenceRule?.contains('MO,') ?? false,
            tuesdaySelected: task.recurrenceRule?.contains('TU,') ?? false,
            wednesdaySelected: task.recurrenceRule?.contains('WE,') ?? false,
            thursdaySelected: task.recurrenceRule?.contains('TH,') ?? false,
            fridaySelected: task.recurrenceRule?.contains('FR,') ?? false,
            saturdaySelected: task.recurrenceRule?.contains('SA,') ?? false,
          ),
        ) {
    on<TaskNameChanged>(_onTaskNameChanged);
    on<NumberOfWorkingSessionsChanged>(_onNumberOfWorkingSessionsChanged);
    on<WorkingDurationChanged>(_onWorkingDurationChanged);
    on<ShortBreakDurationChanged>(_onShortBreakDurationChanged);
    on<MoreInfoChanged>(_onMoreInfoChanged);
    on<StartDateChanged>(_onStartDateChanged);
    on<StartTimeChanged>(_onStartTimeChanged);
    on<SundaySelected>(_onSundaySelected);
    on<MondaySelected>(_onMondaySelected);
    on<TuesdaySelected>(_onTuesdaySelected);
    on<WednesdaySelected>(_onWednesdaySelected);
    on<ThursdaySelected>(_onCreateTaskThursdaySelected);
    on<FridaySelected>(_onFridaySelected);
    on<SaturdaySelected>(_onSaturdaySelected);
    on<FormSubmitted>(_onFormSubmitted);
  }

  final Task _task;
  final AbstractDatabaseRepository _databaseRepository;
  final String _userId;

  @override
  Future<void> close() {
    state.startDateTextEditingController.dispose();
    state.timeOfDayTextingEditingController.dispose();
    return super.close();
  }

  void _onTaskNameChanged(TaskNameChanged event, Emitter<EditTaskState> emit) {
    EditTaskInProgress newState = EditTaskInProgress.copyWithPreviousState(
      previousState: state,
      taskName: TaskName(event.taskName),
      taskNameHasChanged: true,
    );

    emit(newState);
  }

  void _onNumberOfWorkingSessionsChanged(
      NumberOfWorkingSessionsChanged event, Emitter<EditTaskState> emit) {
    EditTaskInProgress newState = EditTaskInProgress.copyWithPreviousState(
      previousState: state,
      numberOfWorkingSessions: event.numberOfWorkingSessions,
    );

    emit(newState);
  }

  void _onWorkingDurationChanged(
      WorkingDurationChanged event, Emitter<EditTaskState> emit) {
    EditTaskInProgress newState = EditTaskInProgress.copyWithPreviousState(
      previousState: state,
      workingDuration: event.workingDuration,
    );

    emit(newState);
  }

  void _onShortBreakDurationChanged(
      ShortBreakDurationChanged event, Emitter<EditTaskState> emit) {
    EditTaskInProgress newState = EditTaskInProgress.copyWithPreviousState(
      previousState: state,
      shortBreakDuration: event.shortBreakDuration,
    );

    emit(newState);
  }

  void _onMoreInfoChanged(MoreInfoChanged event, Emitter<EditTaskState> emit) {
    EditTaskInProgress newState = EditTaskInProgress.copyWithPreviousState(
      previousState: state,
      moreInfo: MoreInfo(event.moreInfo),
      moreInfoHasChanged: true,
    );

    emit(newState);
  }

  void _onStartDateChanged(
      StartDateChanged event, Emitter<EditTaskState> emit) {
    state.startDateTextEditingController.text =
        DateFormat.yMd().format(event.startDate);

    EditTaskInProgress newState = EditTaskInProgress.copyWithPreviousState(
      previousState: state,
      startDate: event.startDate,
    );

    emit(newState);
  }

  void _onStartTimeChanged(
      StartTimeChanged event, Emitter<EditTaskState> emit) {
    state.timeOfDayTextingEditingController.text = getTimeText(event.startTime);

    EditTaskInProgress newState = EditTaskInProgress.copyWithPreviousState(
      previousState: state,
      startTime: event.startTime,
    );

    emit(newState);
  }

  void _onSundaySelected(SundaySelected event, Emitter<EditTaskState> emit) {
    EditTaskInProgress newState = EditTaskInProgress.copyWithPreviousState(
      previousState: state,
      sundaySelected: event.sundaySelected,
    );

    emit(newState);
  }

  void _onMondaySelected(MondaySelected event, Emitter<EditTaskState> emit) {
    EditTaskInProgress newState = EditTaskInProgress.copyWithPreviousState(
      previousState: state,
      mondaySelected: event.mondaySelected,
    );

    emit(newState);
  }

  void _onTuesdaySelected(TuesdaySelected event, Emitter<EditTaskState> emit) {
    EditTaskInProgress newState = EditTaskInProgress.copyWithPreviousState(
      previousState: state,
      tuesdaySelected: event.tuesdaySelected,
    );

    emit(newState);
  }

  void _onWednesdaySelected(
      WednesdaySelected event, Emitter<EditTaskState> emit) {
    EditTaskInProgress newState = EditTaskInProgress.copyWithPreviousState(
      previousState: state,
      wednesdaySelected: event.wednesdaySelected,
    );

    emit(newState);
  }

  void _onCreateTaskThursdaySelected(
      ThursdaySelected event, Emitter<EditTaskState> emit) {
    EditTaskInProgress newState = EditTaskInProgress.copyWithPreviousState(
      previousState: state,
      thursdaySelected: event.thursdaySelected,
    );

    emit(newState);
  }

  void _onFridaySelected(FridaySelected event, Emitter<EditTaskState> emit) {
    EditTaskInProgress newState = EditTaskInProgress.copyWithPreviousState(
      previousState: state,
      fridaySelected: event.fridaySelected,
    );

    emit(newState);
  }

  void _onSaturdaySelected(
      SaturdaySelected event, Emitter<EditTaskState> emit) {
    EditTaskInProgress newState = EditTaskInProgress.copyWithPreviousState(
      previousState: state,
      saturdaySelected: event.saturdaySelected,
    );

    emit(newState);
  }

  Future<void> _onFormSubmitted(
      FormSubmitted event, Emitter<EditTaskState> emit) async {
    EditTaskSubmitting submittingState =
        EditTaskSubmitting.copyFromPreviousState(state);
    emit(submittingState);

    bool isValid = _isStateValid();

    if (!isValid) {
      EditTaskFailure failureState =
          EditTaskFailure.copyFromPreviousState(state);
      emit(failureState);
      return;
    }

    String? recurrenceRule = _generateRecurrenceRule();

    Task updatedTask = Task(
      name: state.taskName.value,
      numberOfWorkingSessions: state.numberOfWorkingSessions.toInt(),
      workingDuration: state.workingDuration.toInt(),
      shortBreakDuration: state.shortBreakDuration.toInt(),
      longBreakDuration: _task.longBreakDuration,
      moreInfo: state.moreInfo.value,
      startDate: state.startDate,
      startTime: state.startTime,
      recurrenceRule: recurrenceRule,
      currentStatus: _task.currentStatus,
    );

    try {
      await _databaseRepository.updateTask(
          userId: _userId, updatedTask: updatedTask);
      EditTaskSubmitted successState =
          EditTaskSubmitted.copyFromPreviousState(state);
      emit(successState);
    } catch (_) {
      EditTaskFailure failureState =
          EditTaskFailure.copyFromPreviousState(state);
      emit(failureState);
    }
  }

  bool _isStateValid() {
    if (!state.taskName.isValid() || !state.moreInfo.isValid()) {
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
