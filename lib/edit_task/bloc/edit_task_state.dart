part of 'edit_task_bloc.dart';

abstract class EditTaskState extends Equatable {
  const EditTaskState({
    required this.taskName,
    required this.taskNameHasChanged,
    required this.numberOfWorkingSessions,
    required this.workingDuration,
    required this.shortBreakDuration,
    required this.moreInfo,
    required this.moreInfoHasChanged,
    required this.formSubmissionAttempted,
    required this.startDate,
    required this.startDateTextEditingController,
    required this.startTime,
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
  final MoreInfo moreInfo;
  final bool moreInfoHasChanged;
  final bool formSubmissionAttempted;
  final DateTime startDate;
  final TextEditingController startDateTextEditingController;
  final TimeOfDay startTime;
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
        shortBreakDuration,
        moreInfo,
        moreInfoHasChanged,
        formSubmissionAttempted,
        startDate,
        startDateTextEditingController,
        startTime,
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

class EditTaskInitial extends EditTaskState {
  const EditTaskInitial({
    required super.taskName,
    super.taskNameHasChanged = false,
    required super.numberOfWorkingSessions,
    required super.workingDuration,
    required super.shortBreakDuration,
    required super.moreInfo,
    super.moreInfoHasChanged = false,
    super.formSubmissionAttempted = false,
    required super.startDate,
    required super.startDateTextEditingController,
    required super.startTime,
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

class EditTaskInProgress extends EditTaskState {
  const EditTaskInProgress({
    required super.taskName,
    required super.taskNameHasChanged,
    required super.numberOfWorkingSessions,
    required super.workingDuration,
    required super.shortBreakDuration,
    required super.moreInfo,
    required super.moreInfoHasChanged,
    required super.formSubmissionAttempted,
    required super.startDate,
    required super.startDateTextEditingController,
    required super.startTime,
    required super.timeOfDayTextingEditingController,
    required super.sundaySelected,
    required super.mondaySelected,
    required super.tuesdaySelected,
    required super.wednesdaySelected,
    required super.thursdaySelected,
    required super.fridaySelected,
    required super.saturdaySelected,
  });

  factory EditTaskInProgress.copyWithPreviousState({
    required EditTaskState previousState,
    TaskName? taskName,
    bool? taskNameHasChanged,
    double? numberOfWorkingSessions,
    double? workingDuration,
    double? shortBreakDuration,
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
    return EditTaskInProgress(
      taskName: taskName ?? previousState.taskName,
      taskNameHasChanged:
          taskNameHasChanged ?? previousState.taskNameHasChanged,
      numberOfWorkingSessions:
          numberOfWorkingSessions ?? previousState.numberOfWorkingSessions,
      workingDuration: workingDuration ?? previousState.workingDuration,
      shortBreakDuration:
          shortBreakDuration ?? previousState.shortBreakDuration,
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

class EditTaskSubmitting extends EditTaskState {
  const EditTaskSubmitting({
    required super.taskName,
    required super.taskNameHasChanged,
    required super.numberOfWorkingSessions,
    required super.workingDuration,
    required super.shortBreakDuration,
    required super.moreInfo,
    required super.moreInfoHasChanged,
    required super.formSubmissionAttempted,
    required super.startDate,
    required super.startDateTextEditingController,
    required super.startTime,
    required super.timeOfDayTextingEditingController,
    required super.sundaySelected,
    required super.mondaySelected,
    required super.tuesdaySelected,
    required super.wednesdaySelected,
    required super.thursdaySelected,
    required super.fridaySelected,
    required super.saturdaySelected,
  });

  factory EditTaskSubmitting.copyFromPreviousState(
      EditTaskState previousState) {
    return EditTaskSubmitting(
      taskName: previousState.taskName,
      taskNameHasChanged: previousState.taskNameHasChanged,
      numberOfWorkingSessions: previousState.numberOfWorkingSessions,
      workingDuration: previousState.workingDuration,
      shortBreakDuration: previousState.shortBreakDuration,
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

class EditTaskSubmitted extends EditTaskState {
  const EditTaskSubmitted({
    required super.taskName,
    required super.taskNameHasChanged,
    required super.numberOfWorkingSessions,
    required super.workingDuration,
    required super.shortBreakDuration,
    required super.moreInfo,
    required super.moreInfoHasChanged,
    required super.formSubmissionAttempted,
    required super.startDate,
    required super.startDateTextEditingController,
    required super.startTime,
    required super.timeOfDayTextingEditingController,
    required super.sundaySelected,
    required super.mondaySelected,
    required super.tuesdaySelected,
    required super.wednesdaySelected,
    required super.thursdaySelected,
    required super.fridaySelected,
    required super.saturdaySelected,
  });

  factory EditTaskSubmitted.copyFromPreviousState(EditTaskState previousState) {
    return EditTaskSubmitted(
      taskName: previousState.taskName,
      taskNameHasChanged: previousState.taskNameHasChanged,
      numberOfWorkingSessions: previousState.numberOfWorkingSessions,
      workingDuration: previousState.workingDuration,
      shortBreakDuration: previousState.shortBreakDuration,
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

class EditTaskFailure extends EditTaskState {
  const EditTaskFailure({
    required super.taskName,
    required super.taskNameHasChanged,
    required super.numberOfWorkingSessions,
    required super.workingDuration,
    required super.shortBreakDuration,
    required super.moreInfo,
    required super.moreInfoHasChanged,
    required super.formSubmissionAttempted,
    required super.startDate,
    required super.startDateTextEditingController,
    required super.startTime,
    required super.timeOfDayTextingEditingController,
    required super.sundaySelected,
    required super.mondaySelected,
    required super.tuesdaySelected,
    required super.wednesdaySelected,
    required super.thursdaySelected,
    required super.fridaySelected,
    required super.saturdaySelected,
  });

  factory EditTaskFailure.copyFromPreviousState(EditTaskState previousState) {
    return EditTaskFailure(
      taskName: previousState.taskName,
      taskNameHasChanged: previousState.taskNameHasChanged,
      numberOfWorkingSessions: previousState.numberOfWorkingSessions,
      workingDuration: previousState.workingDuration,
      shortBreakDuration: previousState.shortBreakDuration,
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
