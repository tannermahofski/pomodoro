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
    this.dateTime,
  });

  final DateTime? dateTime;
}

class CreateTaskEventSubmitButtonClicked extends CreateTaskEvent {}
