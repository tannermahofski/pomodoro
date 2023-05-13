part of 'edit_task_bloc.dart';

abstract class EditTaskEvent extends Equatable {
  const EditTaskEvent();

  @override
  List<Object> get props => [];
}

class TaskNameChanged extends EditTaskEvent {
  const TaskNameChanged({required this.taskName});

  final String taskName;

  @override
  List<Object> get props => [taskName];
}

class NumberOfWorkingSessionsChanged extends EditTaskEvent {
  const NumberOfWorkingSessionsChanged({required this.numberOfWorkingSessions});

  final double numberOfWorkingSessions;

  @override
  List<Object> get props => [numberOfWorkingSessions];
}

class WorkingDurationChanged extends EditTaskEvent {
  const WorkingDurationChanged({required this.workingDuration});

  final double workingDuration;

  @override
  List<Object> get props => [workingDuration];
}

class ShortBreakDurationChanged extends EditTaskEvent {
  const ShortBreakDurationChanged({required this.shortBreakDuration});

  final double shortBreakDuration;

  @override
  List<Object> get props => [shortBreakDuration];
}

class MoreInfoChanged extends EditTaskEvent {
  const MoreInfoChanged({required this.moreInfo});

  final String moreInfo;

  @override
  List<Object> get props => [moreInfo];
}

class StartDateChanged extends EditTaskEvent {
  const StartDateChanged({required this.startDate});

  final DateTime startDate;

  @override
  List<Object> get props => [startDate];
}

class StartTimeChanged extends EditTaskEvent {
  const StartTimeChanged({required this.startTime});

  final TimeOfDay startTime;

  @override
  List<Object> get props => [startTime];
}

class SundaySelected extends EditTaskEvent {
  const SundaySelected({required this.sundaySelected});

  final bool sundaySelected;

  @override
  List<Object> get props => [sundaySelected];
}

class MondaySelected extends EditTaskEvent {
  const MondaySelected({required this.mondaySelected});

  final bool mondaySelected;

  @override
  List<Object> get props => [mondaySelected];
}

class TuesdaySelected extends EditTaskEvent {
  const TuesdaySelected({required this.tuesdaySelected});

  final bool tuesdaySelected;

  @override
  List<Object> get props => [tuesdaySelected];
}

class WednesdaySelected extends EditTaskEvent {
  const WednesdaySelected({required this.wednesdaySelected});

  final bool wednesdaySelected;

  @override
  List<Object> get props => [wednesdaySelected];
}

class ThursdaySelected extends EditTaskEvent {
  const ThursdaySelected({required this.thursdaySelected});

  final bool thursdaySelected;

  @override
  List<Object> get props => [thursdaySelected];
}

class FridaySelected extends EditTaskEvent {
  const FridaySelected({required this.fridaySelected});

  final bool fridaySelected;

  @override
  List<Object> get props => [fridaySelected];
}

class SaturdaySelected extends EditTaskEvent {
  const SaturdaySelected({required this.saturdaySelected});

  final bool saturdaySelected;

  @override
  List<Object> get props => [saturdaySelected];
}

class FormSubmitted extends EditTaskEvent {}
