part of 'create_task_bloc.dart';

abstract class CreateTaskState extends Equatable {
  const CreateTaskState({
    required this.taskName,
    required this.taskNameHasChanged,
    required this.numberOfWorkingSessions,
    required this.workingDuration,
    required this.longBreakDuration,
    required this.shortBreakDuration,
    required this.moreInfo,
    required this.moreInfoHasChanged,
    required this.formSubmissionAttempted,
    this.startDate,
    required this.startDateTextEditingController,
    this.startTime,
    required this.timeOfDayTextingEditingController,
    required this.sundaySelected,
    required this.mondaySelected,
    required this.tuesdaySelected,
    required this.wednesdaySelected,
    required this.thursdaySelected,
    required this.fridaySelected,
    required this.saturdaySelected,
  });

  final TaskName taskName;
  final bool taskNameHasChanged;
  final double numberOfWorkingSessions;
  final double workingDuration;
  final double shortBreakDuration;
  final double longBreakDuration;
  final MoreInfo moreInfo;
  final bool moreInfoHasChanged;
  final bool formSubmissionAttempted;
  final DateTime? startDate;
  final TextEditingController startDateTextEditingController;
  final TimeOfDay? startTime;
  final TextEditingController timeOfDayTextingEditingController;
  final bool saturdaySelected;
  final bool mondaySelected;
  final bool tuesdaySelected;
  final bool wednesdaySelected;
  final bool thursdaySelected;
  final bool fridaySelected;
  final bool sundaySelected;

  @override
  List<Object> get props => [
        taskName,
        taskNameHasChanged,
        workingDuration,
        longBreakDuration,
        shortBreakDuration,
        moreInfo,
        moreInfoHasChanged,
        formSubmissionAttempted,
        startDate ?? DateTime.now(),
        startDateTextEditingController,
        startTime ?? TimeOfDay.now(),
        timeOfDayTextingEditingController,
        saturdaySelected,
        mondaySelected,
        tuesdaySelected,
        wednesdaySelected,
        thursdaySelected,
        fridaySelected,
        sundaySelected,
      ];
}

class CreateTaskInitial extends CreateTaskState {
  const CreateTaskInitial({
    required super.taskName,
    super.taskNameHasChanged = false,
    required super.numberOfWorkingSessions,
    required super.workingDuration,
    required super.longBreakDuration,
    required super.shortBreakDuration,
    required super.moreInfo,
    super.moreInfoHasChanged = false,
    super.formSubmissionAttempted = false,
    super.startDate,
    required super.startDateTextEditingController,
    super.startTime,
    required super.timeOfDayTextingEditingController,
    super.sundaySelected = false,
    super.mondaySelected = false,
    super.tuesdaySelected = false,
    super.wednesdaySelected = false,
    super.thursdaySelected = false,
    super.fridaySelected = false,
    super.saturdaySelected = false,
  });
}

class CreateTaskInProgress extends CreateTaskState {
  const CreateTaskInProgress({
    required super.taskName,
    required super.taskNameHasChanged,
    required super.numberOfWorkingSessions,
    required super.workingDuration,
    required super.longBreakDuration,
    required super.shortBreakDuration,
    required super.moreInfo,
    required super.moreInfoHasChanged,
    required super.formSubmissionAttempted,
    super.startDate,
    required super.startDateTextEditingController,
    super.startTime,
    required super.timeOfDayTextingEditingController,
    required super.sundaySelected,
    required super.mondaySelected,
    required super.tuesdaySelected,
    required super.wednesdaySelected,
    required super.thursdaySelected,
    required super.fridaySelected,
    required super.saturdaySelected,
  });
}

class CreateTaskSubmitting extends CreateTaskState {
  const CreateTaskSubmitting({
    required super.taskName,
    required super.taskNameHasChanged,
    required super.numberOfWorkingSessions,
    required super.workingDuration,
    required super.longBreakDuration,
    required super.shortBreakDuration,
    required super.moreInfo,
    required super.moreInfoHasChanged,
    required super.formSubmissionAttempted,
    super.startDate,
    required super.startDateTextEditingController,
    super.startTime,
    required super.timeOfDayTextingEditingController,
    required super.sundaySelected,
    required super.mondaySelected,
    required super.tuesdaySelected,
    required super.wednesdaySelected,
    required super.thursdaySelected,
    required super.fridaySelected,
    required super.saturdaySelected,
  });
}

class CreateTaskSubmittedSuccesfully extends CreateTaskState {
  const CreateTaskSubmittedSuccesfully({
    required super.taskName,
    required super.taskNameHasChanged,
    required super.numberOfWorkingSessions,
    required super.workingDuration,
    required super.longBreakDuration,
    required super.shortBreakDuration,
    required super.moreInfo,
    required super.moreInfoHasChanged,
    required super.formSubmissionAttempted,
    super.startDate,
    required super.startDateTextEditingController,
    super.startTime,
    required super.timeOfDayTextingEditingController,
    required super.sundaySelected,
    required super.mondaySelected,
    required super.tuesdaySelected,
    required super.wednesdaySelected,
    required super.thursdaySelected,
    required super.fridaySelected,
    required super.saturdaySelected,
  });
}

class CreateTaskSubmittedFailure extends CreateTaskState {
  const CreateTaskSubmittedFailure({
    required super.taskName,
    required super.taskNameHasChanged,
    required super.numberOfWorkingSessions,
    required super.workingDuration,
    required super.longBreakDuration,
    required super.shortBreakDuration,
    required super.moreInfo,
    required super.moreInfoHasChanged,
    required super.formSubmissionAttempted,
    super.startDate,
    required super.startDateTextEditingController,
    super.startTime,
    required super.timeOfDayTextingEditingController,
    required super.sundaySelected,
    required super.mondaySelected,
    required super.tuesdaySelected,
    required super.wednesdaySelected,
    required super.thursdaySelected,
    required super.fridaySelected,
    required super.saturdaySelected,
  });
}
