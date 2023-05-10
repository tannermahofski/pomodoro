import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pomodoro_timer/extensions/date_time_extensions.dart';
import 'package:pomodoro_timer/repositories/abstract_database_repository.dart';
import 'package:pomodoro_timer/shared_models/task.dart';
import 'package:pomodoro_timer/shared_models/user.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required AbstractDatabaseRepository databaseRepository,
    required String userId,
  })  : _databaseRepository = databaseRepository,
        _userId = userId,
        super(HomeInitial()) {
    on<HomeReloadDataRequired>(_onHomeReloadDataRequired);
    on<HomeTaskRemoved>(_onHomeTaskRemoved);

    //Note: This subscription is used to automatically reload the UI
    //Note: For example, adding/removing tasks
    _userSubscription = _databaseRepository.user(userId: userId).listen((user) {
      if (state is! HomeLoadDataInProgress) {
        add(HomeReloadDataRequired(tasks: user.tasks ?? []));
      }
    });
  }

  final AbstractDatabaseRepository _databaseRepository;
  final String _userId;
  late final StreamSubscription<User> _userSubscription;

  Future<void> _onHomeReloadDataRequired(
      HomeReloadDataRequired event, Emitter<HomeState> emit) async {
    emit(HomeLoadDataInProgress());

    TimeOfDay now = TimeOfDay.now();
    String saying;
    if (now.hour > 12) {
      saying = 'Good Afternoon';
    } else {
      saying = 'Good Morning';
    }

    //Note: Here we want to manipulate the tasks to determine the status
    //* Test if it was completed today otherwise not started

    for (int index = 0; index < event.tasks.length; index++) {
      Task currentTask = event.tasks[index];

      if (!currentTask.currentStatus.date.isSameDate(DateTime.now())) {
        Task replacementTask = currentTask.copyWith(
          currentStatus: CurrentStatus(
            workingStatus: WorkingStatus.notStarted,
            date: DateTime.now(),
          ),
        );

        event.tasks[index] = replacementTask;
      }
    }

    emit(HomeLoadDataSuccess(tasks: event.tasks, saying: saying));
  }

  Future<void> _onHomeTaskRemoved(
      HomeTaskRemoved event, Emitter<HomeState> emit) async {
    await _databaseRepository.removeTaskFromUser(
      userId: _userId,
      taskToDelete: event.task,
    );
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
