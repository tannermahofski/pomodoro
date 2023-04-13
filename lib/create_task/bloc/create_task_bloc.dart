import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:pomodoro_timer/create_task/helpers/constants.dart';
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
            workingDuration: kWorkingDurationStartingValue,
            longBreakDuration: kLongBreakDurationStartingValue,
            shortBreakDuration: kShortBreakDurationStartingValue,
            moreInfo: const MoreInfo(''),
            startDateTextEditingController: TextEditingController(),
          ),
        ) {
    on<CreateTaskEventTaskNameChanged>(_onCreateTaskEventTaskNameChanged);
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
    on<CreateTaskEventMoreInfoChanged>(_onCreateTaskEventMoreInfoChanged);
    on<CreateTaskStartDateChanged>(_onCreateTaskStartDateChanged);
  }
  final String _userId;
  final AbstractDatabaseRepository _databaseRepository;

  @override
  Future<void> close() {
    state.startDateTextEditingController.dispose();
    return super.close();
  }

  void _onCreateTaskEventTaskNameChanged(
      CreateTaskEventTaskNameChanged event, Emitter<CreateTaskState> emit) {
    emit(
      CreateTaskInProgress(
        taskName: TaskName(event.taskName),
        taskNameHasChanged: true,
        workingDuration: state.workingDuration,
        longBreakDuration: state.longBreakDuration,
        shortBreakDuration: state.shortBreakDuration,
        moreInfo: state.moreInfo,
        moreInfoHasChanged: state.moreInfoHasChanged,
        formSubmissionAttempted: state.formSubmissionAttempted,
        startDate: state.startDate,
        startDateTextEditingController: state.startDateTextEditingController,
      ),
    );
  }

  void _onCreateTaskEventWorkingDurationChanged(
      CreateTaskEventWorkingDurationChanged event,
      Emitter<CreateTaskState> emit) {
    emit(
      CreateTaskInProgress(
        taskName: state.taskName,
        taskNameHasChanged: state.taskNameHasChanged,
        workingDuration: event.workingDuration,
        longBreakDuration: state.longBreakDuration,
        shortBreakDuration: state.shortBreakDuration,
        moreInfo: state.moreInfo,
        moreInfoHasChanged: state.moreInfoHasChanged,
        formSubmissionAttempted: state.formSubmissionAttempted,
        startDate: state.startDate,
        startDateTextEditingController: state.startDateTextEditingController,
      ),
    );
  }

  void _onCreateTaskEventLongBreakDurationChanged(
      CreateTaskEventLongBreakDurationChanged event,
      Emitter<CreateTaskState> emit) {
    emit(
      CreateTaskInProgress(
        taskName: state.taskName,
        taskNameHasChanged: state.taskNameHasChanged,
        workingDuration: state.workingDuration,
        longBreakDuration: event.longBreakDuration,
        shortBreakDuration: state.shortBreakDuration,
        moreInfo: state.moreInfo,
        moreInfoHasChanged: state.moreInfoHasChanged,
        formSubmissionAttempted: state.formSubmissionAttempted,
        startDate: state.startDate,
        startDateTextEditingController: state.startDateTextEditingController,
      ),
    );
  }

  void _onCreateTaskEventShortBreakDurationChanged(
      CreateTaskEventShortBreakDurationChanged event,
      Emitter<CreateTaskState> emit) {
    emit(
      CreateTaskInProgress(
        taskName: state.taskName,
        taskNameHasChanged: state.taskNameHasChanged,
        workingDuration: state.workingDuration,
        longBreakDuration: state.longBreakDuration,
        shortBreakDuration: event.shortBreakDuration,
        moreInfo: state.moreInfo,
        moreInfoHasChanged: state.moreInfoHasChanged,
        formSubmissionAttempted: state.formSubmissionAttempted,
        startDate: state.startDate,
        startDateTextEditingController: state.startDateTextEditingController,
      ),
    );
  }

  void _onCreateTaskEventMoreInfoChanged(
      CreateTaskEventMoreInfoChanged event, Emitter<CreateTaskState> emit) {
    emit(
      CreateTaskInProgress(
        taskName: state.taskName,
        taskNameHasChanged: state.taskNameHasChanged,
        workingDuration: state.workingDuration,
        longBreakDuration: state.longBreakDuration,
        shortBreakDuration: state.shortBreakDuration,
        moreInfo: MoreInfo(event.moreInfoString),
        moreInfoHasChanged: true,
        formSubmissionAttempted: state.formSubmissionAttempted,
        startDate: state.startDate,
        startDateTextEditingController: state.startDateTextEditingController,
      ),
    );
  }

  void _onCreateTaskStartDateChanged(
      CreateTaskStartDateChanged event, Emitter<CreateTaskState> emit) {
    String? text;
    if (event.dateTime != null) {
      text = DateFormat.yMd().format(event.dateTime!);
    }
    state.startDateTextEditingController.text = text ?? '';
    emit(
      CreateTaskInProgress(
        taskName: state.taskName,
        taskNameHasChanged: state.taskNameHasChanged,
        workingDuration: state.workingDuration,
        longBreakDuration: state.longBreakDuration,
        shortBreakDuration: state.shortBreakDuration,
        moreInfo: state.moreInfo,
        moreInfoHasChanged: state.moreInfoHasChanged,
        formSubmissionAttempted: state.formSubmissionAttempted,
        startDate: event.dateTime,
        startDateTextEditingController: state.startDateTextEditingController,
      ),
    );
  }

  Future<void> _onCreateTaskEventSubmitButtonClicked(
      CreateTaskEventSubmitButtonClicked event,
      Emitter<CreateTaskState> emit) async {
    emit(
      CreateTaskSubmitting(
        taskName: state.taskName,
        taskNameHasChanged: state.taskNameHasChanged,
        workingDuration: state.workingDuration,
        longBreakDuration: state.longBreakDuration,
        shortBreakDuration: state.shortBreakDuration,
        moreInfo: state.moreInfo,
        moreInfoHasChanged: state.moreInfoHasChanged,
        formSubmissionAttempted: true,
        startDate: state.startDate,
        startDateTextEditingController: state.startDateTextEditingController,
      ),
    );
    if (!state.taskName.isValid() || !state.moreInfo.isValid()) {
      emit(
        CreateTaskSubmittedFailure(
          taskName: state.taskName,
          taskNameHasChanged: state.taskNameHasChanged,
          workingDuration: state.workingDuration,
          longBreakDuration: state.longBreakDuration,
          shortBreakDuration: state.shortBreakDuration,
          moreInfo: state.moreInfo,
          moreInfoHasChanged: state.moreInfoHasChanged,
          formSubmissionAttempted: state.formSubmissionAttempted,
          startDate: state.startDate,
          startDateTextEditingController: state.startDateTextEditingController,
        ),
      );
      return;
    }

    Task task = Task(
      name: state.taskName.value,
      workingDuration: state.workingDuration.toString(),
      shortBreakDuration: state.shortBreakDuration.toString(),
      longBreakDuration: state.longBreakDuration.toString(),
      moreInfo: state.moreInfo.value,
    );

    try {
      await _databaseRepository.addTaskToUser(
        userId: _userId,
        task: task,
      );

      emit(
        CreateTaskSubmittedSuccesfully(
          taskName: state.taskName,
          taskNameHasChanged: state.taskNameHasChanged,
          workingDuration: state.workingDuration,
          longBreakDuration: state.longBreakDuration,
          shortBreakDuration: state.shortBreakDuration,
          moreInfo: state.moreInfo,
          moreInfoHasChanged: state.moreInfoHasChanged,
          formSubmissionAttempted: state.formSubmissionAttempted,
          startDate: state.startDate,
          startDateTextEditingController: state.startDateTextEditingController,
        ),
      );
    } on Exception catch (_) {
      emit(
        CreateTaskSubmittedFailure(
          taskName: state.taskName,
          taskNameHasChanged: state.taskNameHasChanged,
          workingDuration: state.workingDuration,
          longBreakDuration: state.longBreakDuration,
          shortBreakDuration: state.shortBreakDuration,
          moreInfo: state.moreInfo,
          moreInfoHasChanged: state.moreInfoHasChanged,
          formSubmissionAttempted: state.formSubmissionAttempted,
          startDate: state.startDate,
          startDateTextEditingController: state.startDateTextEditingController,
        ),
      );
    }
  }
}
