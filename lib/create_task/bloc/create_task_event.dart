part of 'create_task_bloc.dart';

abstract class CreateTaskEvent extends Equatable {
  const CreateTaskEvent();

  @override
  List<Object> get props => [];
}

class CreateTaskEventTaskNameChanged extends CreateTaskEvent {
  const CreateTaskEventTaskNameChanged({required this.taskName});

  final String taskName;

  @override
  List<Object> get props => [taskName];
}

class CreateTaskEventNumberOfWorkingSessionsChanged extends CreateTaskEvent {
  const CreateTaskEventNumberOfWorkingSessionsChanged({
    required this.numberOfWorkingSessions,
  });

  final double numberOfWorkingSessions;

  @override
  List<Object> get props => [numberOfWorkingSessions];
}

class CreateTaskEventWorkingDurationChanged extends CreateTaskEvent {
  const CreateTaskEventWorkingDurationChanged({
    required this.workingDuration,
  });

  final double workingDuration;

  @override
  List<Object> get props => [workingDuration];
}

class CreateTaskEventLongBreakDurationChanged extends CreateTaskEvent {
  const CreateTaskEventLongBreakDurationChanged({
    required this.longBreakDuration,
  });

  final double longBreakDuration;

  @override
  List<Object> get props => [longBreakDuration];
}

class CreateTaskEventShortBreakDurationChanged extends CreateTaskEvent {
  const CreateTaskEventShortBreakDurationChanged({
    required this.shortBreakDuration,
  });

  final double shortBreakDuration;

  @override
  List<Object> get props => [shortBreakDuration];
}

class CreateTaskEventMoreInfoChanged extends CreateTaskEvent {
  const CreateTaskEventMoreInfoChanged({
    required this.moreInfoString,
  });

  final String moreInfoString;

  @override
  List<Object> get props => [moreInfoString];
}

class CreateTaskStartDateChanged extends CreateTaskEvent {
  const CreateTaskStartDateChanged({
    this.startDate,
  });

  final DateTime? startDate;

  @override
  List<Object> get props => startDate != null ? [startDate!] : [];
}

class CreateTaskTimeChanged extends CreateTaskEvent {
  const CreateTaskTimeChanged({
    this.startTime,
  });

  final TimeOfDay? startTime;

  @override
  List<Object> get props => startTime != null ? [startTime!] : [];
}

class CreateTaskSundaySelected extends CreateTaskEvent {
  const CreateTaskSundaySelected({this.value});

  final bool? value;

  @override
  List<Object> get props => [value ?? false];
}

class CreateTaskMondaySelected extends CreateTaskEvent {
  const CreateTaskMondaySelected({this.value});

  final bool? value;

  @override
  List<Object> get props => [value ?? false];
}

class CreateTaskTuesdaySelected extends CreateTaskEvent {
  const CreateTaskTuesdaySelected({this.value});

  final bool? value;

  @override
  List<Object> get props => [value ?? false];
}

class CreateTaskWednesdaySelected extends CreateTaskEvent {
  const CreateTaskWednesdaySelected({this.value});

  final bool? value;

  @override
  List<Object> get props => [value ?? false];
}

class CreateTaskThursdaySelected extends CreateTaskEvent {
  const CreateTaskThursdaySelected({this.value});

  final bool? value;

  @override
  List<Object> get props => [value ?? false];
}

class CreateTaskFridaySelected extends CreateTaskEvent {
  const CreateTaskFridaySelected({this.value});

  final bool? value;

  @override
  List<Object> get props => [value ?? false];
}

class CreateTaskSaturdaySelected extends CreateTaskEvent {
  const CreateTaskSaturdaySelected({this.value});

  final bool? value;

  @override
  List<Object> get props => [value ?? false];
}

class CreateTaskEventSubmitButtonClicked extends CreateTaskEvent {}
