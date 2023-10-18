import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_timer/helpers/constants/maps.dart';
import 'package:pomodoro_timer/helpers/constants/model_constants.dart';

//TODO: Remove long break duration
class Task extends Equatable {
  const Task({
    required this.name,
    required this.numberOfWorkingSessions,
    required this.workingDuration,
    required this.shortBreakDuration,
    required this.moreInfo,
    this.startDate,
    this.startTime,
    this.recurrenceRule,
    required this.currentStatus,
  });

  final String name;
  final int numberOfWorkingSessions;
  final int workingDuration;
  final int shortBreakDuration;
  final String moreInfo;
  final DateTime? startDate;
  final TimeOfDay? startTime;
  final String? recurrenceRule;
  final CurrentStatus currentStatus;

  bool shouldCompleteToday() {
    DateTime today = DateTime.now();

    if (recurrenceRule == null) {
      return false;
    }

    List<String> recurrenceRuleSplit = recurrenceRule!.split('BYDAY=');

    String daysInRecurrenceRule = recurrenceRuleSplit.last;

    List<String> dayAbbreviations = daysInRecurrenceRule.split(',');
    List<int> days = [];

    for (String dayAbbreviation in dayAbbreviations) {
      int? day = recurrenceRuleToDayMap[dayAbbreviation];

      if (day == null) {
        continue;
      }

      days.add(day);
    }

    return days.contains(today.weekday);
  }

  factory Task.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> snapshot = doc.data()!;
    Task task = Task(
      name: snapshot[kName],
      numberOfWorkingSessions: snapshot[kNumberOfWorkingSessions],
      workingDuration: snapshot[kWorkingDuration],
      shortBreakDuration: snapshot[kShortBreakDuration],
      moreInfo: snapshot[kMoreInfo],
      startDate: snapshot.containsKey(kStartDate)
          ? snapshot[kStartDate].toDate()
          : null,
      startTime: snapshot.containsKey(kTimeOfDay) ? snapshot[kTimeOfDay] : null,
      recurrenceRule: snapshot.containsKey(kRecurrenceRule)
          ? snapshot[kRecurrenceRule]
          : null,
      currentStatus: CurrentStatus.fromJson(snapshot[kCurrentStatus]),
    );

    return task;
  }

  factory Task.fromMap(Map<String, dynamic> json) {
    return Task(
      name: json[kName],
      numberOfWorkingSessions: json[kNumberOfWorkingSessions],
      workingDuration: json[kWorkingDuration],
      shortBreakDuration: json[kShortBreakDuration],
      moreInfo: json[kMoreInfo],
      startDate:
          json.containsKey(kStartDate) ? json[kStartDate].toDate() : null,
      startTime: json.containsKey(kTimeOfDay)
          ? TimeOfDay(
              hour: int.parse(json[kTimeOfDay].toString().split("*").first),
              minute: int.parse(json[kTimeOfDay].toString().split("*").last))
          : null,
      recurrenceRule:
          json.containsKey(kRecurrenceRule) ? json[kRecurrenceRule] : null,
      currentStatus: CurrentStatus.fromJson(json[kCurrentStatus]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      kName: name,
      kNumberOfWorkingSessions: numberOfWorkingSessions,
      kWorkingDuration: workingDuration,
      kShortBreakDuration: shortBreakDuration,
      kMoreInfo: moreInfo,
      kStartDate: startDate,
      kTimeOfDay: ("${startTime?.hour}*${startTime?.minute}"),
      kRecurrenceRule: recurrenceRule,
      kCurrentStatus: currentStatus.toMap(),
    };
  }

  Task copyWith({
    String? name,
    int? numberOfWorkingSessions,
    int? workingDuration,
    int? shortBreakDuration,
    int? longBreakDuration,
    String? moreInfo,
    DateTime? startDate,
    TimeOfDay? startTime,
    String? recurrenceRule,
    CurrentStatus? currentStatus,
  }) {
    return Task(
      name: name ?? this.name,
      numberOfWorkingSessions:
          numberOfWorkingSessions ?? this.numberOfWorkingSessions,
      workingDuration: workingDuration ?? this.workingDuration,
      shortBreakDuration: shortBreakDuration ?? this.shortBreakDuration,
      moreInfo: moreInfo ?? this.moreInfo,
      startDate: startDate ?? this.startDate,
      startTime: startTime ?? this.startTime,
      recurrenceRule: recurrenceRule ?? this.recurrenceRule,
      currentStatus: currentStatus ?? this.currentStatus,
    );
  }

  @override
  List<Object?> get props => [
        name,
        // numberOfWorkingSessions,
        // workingDuration,
        // shortBreakDuration,
        // longBreakDuration,
        // moreInfo,
      ];
}

enum WorkingStatus { completed, inProgress, notStarted }

class CurrentStatus extends Equatable {
  const CurrentStatus({required this.workingStatus, required this.date});

  final WorkingStatus workingStatus;
  final DateTime date;

  factory CurrentStatus.fromJson(
    Map<String, dynamic> json,
  ) {
    return CurrentStatus(
      workingStatus: WorkingStatus.values[json[kWorkingStatus]],
      date: json[kDate].toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      kWorkingStatus: workingStatus.index,
      kDate: date,
    };

    return map;
  }

  @override
  List<Object?> get props => [
        workingStatus,
        date,
      ];
}
