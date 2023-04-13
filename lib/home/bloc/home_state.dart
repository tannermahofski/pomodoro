part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoadDataInProgress extends HomeState {}

class HomeLoadDataSuccess extends HomeState {
  const HomeLoadDataSuccess({this.tasks});

  final List<Task>? tasks;

  @override
  List<Object> get props => [tasks ?? []];
}
