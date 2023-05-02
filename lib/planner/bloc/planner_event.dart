part of 'planner_bloc.dart';

abstract class PlannerEvent extends Equatable {
  const PlannerEvent();

  @override
  List<Object> get props => [];
}

class PlannerReloadDataRequired extends PlannerEvent {
  const PlannerReloadDataRequired({required this.tasks});

  final List<Task> tasks;

  @override
  List<Object> get props => [tasks];
}
