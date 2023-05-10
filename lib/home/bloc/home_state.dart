part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoadDataInProgress extends HomeState {}

class HomeLoadDataSuccess extends HomeState {
  const HomeLoadDataSuccess({
    this.tasks,
    required this.saying,
  });

  final List<Task>? tasks;
  final String saying;

  @override
  List<Object> get props => [
        tasks ?? [],
        saying,
      ];
}
