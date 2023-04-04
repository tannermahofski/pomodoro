import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pomodoro_timer/repositories/database_repository.dart';
import 'package:pomodoro_timer/shared_models/task.dart';
import 'package:pomodoro_timer/shared_models/user.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required DatabaseRepository databaseRepository,
    required String userId,
  })  : _databaseRepository = databaseRepository,
        _userId = userId,
        super(HomeInitial()) {
    on<HomeStarted>(_onHomeStarted);
    on<HomeAddNewTaskButtonPressed>(_onHomeAddNewTaskButtonPressed);
    on<HomeReloadTasksRequired>(_onHomReloadTasksRequired);

    _userSubscription = _databaseRepository.user(userId).listen((user) {
      if (state is! HomeInitial && state is! HomeUserDataLoadInProgress) {
        print('hit');
        print(state);
        add(HomeReloadTasksRequired(tasks: user.tasks ?? []));
      }
    });

    if (state is HomeInitial) {
      add(HomeStarted());
    }
  }

  final DatabaseRepository _databaseRepository;
  final String _userId;
  late final StreamSubscription<User> _userSubscription;

  Future<void> _onHomeStarted(
      HomeStarted event, Emitter<HomeState> emit) async {
    emit(HomeUserDataLoadInProgress());

    List<Task>? tasks = await _databaseRepository.retrieveUserTasks(_userId);

    await Future.delayed(const Duration(seconds: 1));

    emit(HomeUserDataLoadSuccess(tasks: tasks));
  }

  Future<void> _onHomeAddNewTaskButtonPressed(
      HomeAddNewTaskButtonPressed event, Emitter<HomeState> emit) async {
    await _databaseRepository.addTaskToUser(_userId);
    //Note: This will trigger the stream listener to get hit, calling _onHomReloadTasksRequired
  }

  Future<void> _onHomReloadTasksRequired(
      HomeReloadTasksRequired event, Emitter<HomeState> emit) async {
    emit(HomeReloadTasksInProgress());
    await Future.delayed(const Duration(seconds: 2));
    emit(HomeReloadTasksSuccess(tasks: event.tasks));
  }
}
