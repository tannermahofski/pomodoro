part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeUserDataLoadInProgress extends HomeState {}

class HomeReloadTasksInProgress extends HomeState {}

class HomeUserDataLoadSuccess extends HomeState {
  const HomeUserDataLoadSuccess({this.tasks});

  final List<Task>? tasks;

  @override
  List<Object> get props => [tasks ?? []];
}

class HomeNavigatingToCreateTaskScreen extends HomeState {}
