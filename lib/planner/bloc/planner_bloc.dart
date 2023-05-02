import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pomodoro_timer/planner/models/task_data_source.dart';
import 'package:pomodoro_timer/repositories/abstract_database_repository.dart';
import 'package:pomodoro_timer/shared_models/task.dart';

part 'planner_event.dart';
part 'planner_state.dart';

class PlannerBloc extends Bloc<PlannerEvent, PlannerState> {
  PlannerBloc({
    required AbstractDatabaseRepository databaseRepository,
    required String userId,
  })  : _databaseRepository = databaseRepository,
        _userId = userId,
        super(PlannerInitial()) {
    on<PlannerReloadDataRequired>(_onPlannerReloadRequired);

    //Note: This subscription is used to automatically reload the UI
    //Note: For example, adding/removing tasks
    _userSubscription = _databaseRepository.user(userId: userId).listen((user) {
      if (state is! PlannerLoadDataInProgress) {
        add(PlannerReloadDataRequired(tasks: user.tasks ?? []));
      }
    });
  }

  final AbstractDatabaseRepository _databaseRepository;
  final String _userId;
  late final StreamSubscription _userSubscription;

  void _onPlannerReloadRequired(
      PlannerReloadDataRequired event, Emitter<PlannerState> emit) {
    emit(PlannerLoadDataInProgress());

    TaskDataSource taskDataSource = TaskDataSource(event.tasks);

    emit(PlannerLoadDataSuccess(
        tasks: event.tasks, taskDataSource: taskDataSource));
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
