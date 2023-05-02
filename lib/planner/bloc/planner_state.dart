part of 'planner_bloc.dart';

abstract class PlannerState extends Equatable {
  const PlannerState();

  @override
  List<Object> get props => [];
}

class PlannerInitial extends PlannerState {}

class PlannerLoadDataInProgress extends PlannerState {}

class PlannerLoadDataSuccess extends PlannerState {
  const PlannerLoadDataSuccess({
    this.tasks,
    this.taskDataSource,
  });

  final List<Task>? tasks;
  final TaskDataSource? taskDataSource;

  @override
  List<Object> get props => [tasks ?? []];
}
