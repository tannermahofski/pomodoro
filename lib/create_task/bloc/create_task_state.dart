part of 'create_task_bloc.dart';

abstract class CreateTaskState extends Equatable {
  const CreateTaskState({
    required this.taskName,
    required this.taskNameHasChanged,
    required this.workingDuration,
    required this.longBreakDuration,
    required this.shortBreakDuration,
    required this.moreInfo,
    required this.moreInfoHasChanged,
  });

  final TaskName taskName;
  final bool taskNameHasChanged;
  final double workingDuration;
  final double shortBreakDuration;
  final double longBreakDuration;
  final MoreInfo moreInfo;
  final bool moreInfoHasChanged;

  @override
  List<Object> get props => [
        taskName,
        taskNameHasChanged,
        workingDuration,
        longBreakDuration,
        shortBreakDuration,
        moreInfo,
        moreInfoHasChanged,
      ];
}

class CreateTaskInitial extends CreateTaskState {
  const CreateTaskInitial({
    required super.taskName,
    super.taskNameHasChanged = false,
    required super.workingDuration,
    required super.longBreakDuration,
    required super.shortBreakDuration,
    required super.moreInfo,
    super.moreInfoHasChanged = false,
  });
}

class CreateTaskInProgress extends CreateTaskState {
  const CreateTaskInProgress({
    required super.taskName,
    required super.taskNameHasChanged,
    required super.workingDuration,
    required super.longBreakDuration,
    required super.shortBreakDuration,
    required super.moreInfo,
    required super.moreInfoHasChanged,
  });
}

class CreateTaskSubmitting extends CreateTaskState {
  const CreateTaskSubmitting({
    required super.taskName,
    required super.taskNameHasChanged,
    required super.workingDuration,
    required super.longBreakDuration,
    required super.shortBreakDuration,
    required super.moreInfo,
    required super.moreInfoHasChanged,
  });
}

class CreateTaskSubmittedSuccesfully extends CreateTaskState {
  const CreateTaskSubmittedSuccesfully({
    required super.taskName,
    required super.taskNameHasChanged,
    required super.workingDuration,
    required super.longBreakDuration,
    required super.shortBreakDuration,
    required super.moreInfo,
    required super.moreInfoHasChanged,
  });
}
