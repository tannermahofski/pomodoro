import 'package:flutter/material.dart';
import 'package:pomodoro_timer/helpers/constants/color_constants.dart';
import 'package:pomodoro_timer/shared_models/task.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TaskDataSource extends CalendarDataSource {
  TaskDataSource(List<Task> tasks) {
    appointments = tasks;
  }

  @override
  DateTime getStartTime(int index) {
    DateTime startDate = getStart(index);
    return startDate;
  }

  @override
  DateTime getEndTime(int index) {
    DateTime startDate = getStart(index);
    double hoursElapsed = getHoursElapsed(index);
    int hours = hoursElapsed.floor();
    int minutes = ((hoursElapsed - hours) * 60).toInt();

    DateTime endDate = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
      startDate.hour + hours,
      startDate.minute + minutes,
    );
    return endDate;
  }

  @override
  String getSubject(int index) {
    return appointments![index].name;
  }

  @override
  String? getRecurrenceRule(int index) {
    String? recurrenceRule = appointments![index].recurrenceRule;
    return recurrenceRule;
  }

  @override
  Color getColor(int index) {
    return kVioletBlue;
  }

  DateTime getStart(int index) {
    DateTime startDate = appointments![index].startDate;
    TimeOfDay startTime = appointments![index].startTime;

    startDate = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
      startTime.hour,
      startTime.minute,
    );
    return startDate;
  }

  double getHoursElapsed(int index) {
    Task task = appointments![index];

    int minutesElapsed = (task.numberOfWorkingSessions * task.workingDuration) +
        ((task.numberOfWorkingSessions - 1) * task.shortBreakDuration);

    return (minutesElapsed / 60);
  }
}
