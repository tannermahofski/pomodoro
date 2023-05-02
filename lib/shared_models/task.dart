import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_timer/helpers/constants/model_constants.dart';

class Task extends Equatable {
  const Task({
    required this.name,
    required this.numberOfWorkingSessions,
    required this.workingDuration,
    required this.shortBreakDuration,
    required this.longBreakDuration,
    required this.moreInfo,
    this.startDate,
    this.startTime,
    this.recurrenceRule,
  });

  final String name;
  final int numberOfWorkingSessions;
  final int workingDuration;
  final int shortBreakDuration;
  final int longBreakDuration;
  final String moreInfo;
  final DateTime? startDate;
  final TimeOfDay? startTime;
  final String? recurrenceRule;

  factory Task.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> snapshot = doc.data()!;
    Task task = Task(
      name: snapshot[kName],
      numberOfWorkingSessions: snapshot[kNumberOfWorkingSessions],
      workingDuration: snapshot[kWorkingDuration],
      shortBreakDuration: snapshot[kShortBreakDuration],
      longBreakDuration: snapshot[kLongBreakDuration],
      moreInfo: snapshot[kMoreInfo],
      startDate: snapshot.containsKey(kStartDate)
          ? snapshot[kStartDate].toDate()
          : null,
      startTime: snapshot.containsKey(kTimeOfDay) ? snapshot[kTimeOfDay] : null,
      recurrenceRule: snapshot.containsKey(kRecurrenceRule)
          ? snapshot[kRecurrenceRule]
          : null,
    );

    return task;
  }

  factory Task.fromMap(Map<String, dynamic> json) {
    return Task(
      name: json[kName],
      numberOfWorkingSessions: json[kNumberOfWorkingSessions],
      workingDuration: json[kWorkingDuration],
      shortBreakDuration: json[kShortBreakDuration],
      longBreakDuration: json[kLongBreakDuration],
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
    );
  }

  Map<String, dynamic> toMap() {
    return {
      kName: name,
      kNumberOfWorkingSessions: numberOfWorkingSessions,
      kWorkingDuration: workingDuration,
      kShortBreakDuration: shortBreakDuration,
      kLongBreakDuration: longBreakDuration,
      kMoreInfo: moreInfo,
      kStartDate: startDate,
      kTimeOfDay: ("${startTime?.hour}*${startTime?.minute}"),
      kRecurrenceRule: recurrenceRule,
    };
  }

  @override
  List<Object?> get props => [
        name,
        numberOfWorkingSessions,
        workingDuration,
        shortBreakDuration,
        longBreakDuration,
        moreInfo,
      ];
}
