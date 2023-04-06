import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pomodoro_timer/create_task/models/more_info.dart';
import 'package:pomodoro_timer/create_task/models/task_name.dart';
import 'package:pomodoro_timer/repositories/database_repository.dart';
import 'package:pomodoro_timer/shared_models/task.dart';

part 'create_task_event.dart';
part 'create_task_state.dart';

class CreateTaskBloc extends Bloc<CreateTaskEvent, CreateTaskState> {
  CreateTaskBloc({
    required String userId,
    required DatabaseRepository databaseRepository,
  })  : _userId = userId,
        _databaseRepository = databaseRepository,
        super(
          const CreateTaskInitial(
            taskName: TaskName(''),
            workingDuration: 5,
            longBreakDuration: 10,
            shortBreakDuration: 5,
            moreInfo: MoreInfo(''),
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
  }
  final String _userId;
  final DatabaseRepository _databaseRepository;

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
        moreInfoHasChanged: false,
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
      ),
    );

    Task task = Task(
      name: state.taskName.value,
      workingDuration: state.workingDuration.toString(),
      shortBreakDuration: state.shortBreakDuration.toString(),
      longBreakDuration: state.longBreakDuration.toString(),
      moreInfo: state.moreInfo.value,
    );

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
      ),
    );
  }
}
