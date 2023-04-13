part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeReloadDataRequired extends HomeEvent {
  const HomeReloadDataRequired({required this.tasks});

  final List<Task> tasks;

  @override
  List<Object> get props => [tasks];
}

class HomeTaskRemoved extends HomeEvent {
  const HomeTaskRemoved({required this.task});
  final Task task;
}
