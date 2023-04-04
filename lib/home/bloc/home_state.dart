part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState({this.tasks});

  final List<Task>? tasks;

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeUserDataLoadInProgress extends HomeState {}

class HomeUserDataLoadSuccess extends HomeState {
  const HomeUserDataLoadSuccess({super.tasks});

  @override
  List<Object> get props => [tasks ?? []];
}

class HomeNewTaskInProgress extends HomeState {}

class HomeNewTaskSuccess extends HomeState {}

class HomeReloadTasksInProgress extends HomeState {}

class HomeReloadTasksSuccess extends HomeState {
  const HomeReloadTasksSuccess({super.tasks});

  // final List<Task>? tasks;

  @override
  List<Object> get props => [super.tasks ?? []];
}
