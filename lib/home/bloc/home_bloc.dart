import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
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
    emit(HomeLoadDataSuccess(tasks: event.tasks));
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
