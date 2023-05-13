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
        numberOfWorkingSessions,
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

  factory CreateTaskInProgress.copyWithPreviousState({
    required CreateTaskState previousState,
    TaskName? taskName,
    bool? taskNameHasChanged,
    double? numberOfWorkingSessions,
    double? workingDuration,
    double? shortBreakDuration,
    double? longBreakDuration,
    MoreInfo? moreInfo,
    bool? moreInfoHasChanged,
    bool? formSubmissionAttempted,
    DateTime? startDate,
    TextEditingController? startDateTextEditingController,
    TimeOfDay? startTime,
    TextEditingController? timeOfDayTextingEditingController,
    bool? saturdaySelected,
    bool? mondaySelected,
    bool? tuesdaySelected,
    bool? wednesdaySelected,
    bool? thursdaySelected,
    bool? fridaySelected,
    bool? sundaySelected,
  }) {
    return CreateTaskInProgress(
      taskName: taskName ?? previousState.taskName,
      taskNameHasChanged:
          taskNameHasChanged ?? previousState.taskNameHasChanged,
      numberOfWorkingSessions:
          numberOfWorkingSessions ?? previousState.numberOfWorkingSessions,
      workingDuration: workingDuration ?? previousState.workingDuration,
      shortBreakDuration:
          shortBreakDuration ?? previousState.shortBreakDuration,
      longBreakDuration: longBreakDuration ?? previousState.longBreakDuration,
      moreInfo: moreInfo ?? previousState.moreInfo,
      moreInfoHasChanged:
          moreInfoHasChanged ?? previousState.moreInfoHasChanged,
      formSubmissionAttempted:
          formSubmissionAttempted ?? previousState.formSubmissionAttempted,
      startDate: startDate ?? previousState.startDate,
      startDateTextEditingController: startDateTextEditingController ??
          previousState.startDateTextEditingController,
      startTime: startTime ?? previousState.startTime,
      timeOfDayTextingEditingController: timeOfDayTextingEditingController ??
          previousState.timeOfDayTextingEditingController,
      sundaySelected: sundaySelected ?? previousState.sundaySelected,
      mondaySelected: mondaySelected ?? previousState.mondaySelected,
      tuesdaySelected: tuesdaySelected ?? previousState.tuesdaySelected,
      wednesdaySelected: wednesdaySelected ?? previousState.wednesdaySelected,
      thursdaySelected: thursdaySelected ?? previousState.thursdaySelected,
      fridaySelected: fridaySelected ?? previousState.fridaySelected,
      saturdaySelected: saturdaySelected ?? previousState.saturdaySelected,
    );
  }
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

  factory CreateTaskSubmitting.fromPreviousState({
    required CreateTaskState previousState,
    DateTime? startDate,
    TimeOfDay? startTime,
  }) {
    return CreateTaskSubmitting(
      taskName: previousState.taskName,
      taskNameHasChanged: previousState.taskNameHasChanged,
      numberOfWorkingSessions: previousState.numberOfWorkingSessions,
      workingDuration: previousState.workingDuration,
      shortBreakDuration: previousState.shortBreakDuration,
      longBreakDuration: previousState.longBreakDuration,
      moreInfo: previousState.moreInfo,
      moreInfoHasChanged: previousState.moreInfoHasChanged,
      formSubmissionAttempted: true,
      startDate: startDate ?? previousState.startDate,
      startDateTextEditingController:
          previousState.startDateTextEditingController,
      startTime: startTime ?? previousState.startTime,
      timeOfDayTextingEditingController:
          previousState.timeOfDayTextingEditingController,
      sundaySelected: previousState.sundaySelected,
      mondaySelected: previousState.mondaySelected,
      tuesdaySelected: previousState.tuesdaySelected,
      wednesdaySelected: previousState.wednesdaySelected,
      thursdaySelected: previousState.thursdaySelected,
      fridaySelected: previousState.fridaySelected,
      saturdaySelected: previousState.saturdaySelected,
    );
  }
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

  factory CreateTaskSubmittedSuccesfully.copyFromPreviousState(
      CreateTaskState previousState) {
    return CreateTaskSubmittedSuccesfully(
      taskName: previousState.taskName,
      taskNameHasChanged: previousState.taskNameHasChanged,
      numberOfWorkingSessions: previousState.numberOfWorkingSessions,
      workingDuration: previousState.workingDuration,
      shortBreakDuration: previousState.shortBreakDuration,
      longBreakDuration: previousState.longBreakDuration,
      moreInfo: previousState.moreInfo,
      moreInfoHasChanged: previousState.moreInfoHasChanged,
      formSubmissionAttempted: previousState.formSubmissionAttempted,
      startDate: previousState.startDate,
      startDateTextEditingController:
          previousState.startDateTextEditingController,
      startTime: previousState.startTime,
      timeOfDayTextingEditingController:
          previousState.timeOfDayTextingEditingController,
      sundaySelected: previousState.sundaySelected,
      mondaySelected: previousState.mondaySelected,
      tuesdaySelected: previousState.tuesdaySelected,
      wednesdaySelected: previousState.wednesdaySelected,
      thursdaySelected: previousState.thursdaySelected,
      fridaySelected: previousState.fridaySelected,
      saturdaySelected: previousState.saturdaySelected,
    );
  }
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

  factory CreateTaskSubmittedFailure.copyFromPreviousState(
      CreateTaskState previousState) {
    return CreateTaskSubmittedFailure(
      taskName: previousState.taskName,
      taskNameHasChanged: previousState.taskNameHasChanged,
      numberOfWorkingSessions: previousState.numberOfWorkingSessions,
      workingDuration: previousState.workingDuration,
      shortBreakDuration: previousState.shortBreakDuration,
      longBreakDuration: previousState.longBreakDuration,
      moreInfo: previousState.moreInfo,
      moreInfoHasChanged: previousState.moreInfoHasChanged,
      formSubmissionAttempted: previousState.formSubmissionAttempted,
      startDate: previousState.startDate,
      startDateTextEditingController:
          previousState.startDateTextEditingController,
      startTime: previousState.startTime,
      timeOfDayTextingEditingController:
          previousState.timeOfDayTextingEditingController,
      sundaySelected: previousState.sundaySelected,
      mondaySelected: previousState.mondaySelected,
      tuesdaySelected: previousState.tuesdaySelected,
      wednesdaySelected: previousState.wednesdaySelected,
      thursdaySelected: previousState.thursdaySelected,
      fridaySelected: previousState.fridaySelected,
      saturdaySelected: previousState.saturdaySelected,
    );
  }
}
