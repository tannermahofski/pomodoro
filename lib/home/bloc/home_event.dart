part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeStarted extends HomeEvent {}

class HomeAddNewTaskButtonPressed extends HomeEvent {
  const HomeAddNewTaskButtonPressed({
    required this.userId,
  });
  final String userId;
}

class HomeReloadTasksRequired extends HomeEvent {
  const HomeReloadTasksRequired({required this.tasks});

  final List<Task> tasks;

  @override
  List<Object> get props => [tasks];
}
