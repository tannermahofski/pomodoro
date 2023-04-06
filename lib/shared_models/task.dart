import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:pomodoro_timer/helpers/constants/model_constants.dart';

class Task extends Equatable {
  const Task({
    required this.name,
    required this.workingDuration,
    required this.shortBreakDuration,
    required this.longBreakDuration,
    required this.moreInfo,
  });

  final String name;
  final String workingDuration;
  final String shortBreakDuration;
  final String longBreakDuration;

  final String moreInfo;

  factory Task.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> snapshot = doc.data()!;
    return Task(
      name: snapshot[kName],
      workingDuration: snapshot[kWorkingDuration],
      shortBreakDuration: snapshot[kShortBreakDuration],
      longBreakDuration: snapshot[kLongBreakDuration],
      moreInfo: snapshot[kMoreInfo],
    );
  }

  factory Task.fromMap(Map<String, dynamic> json) {
    return Task(
      name: json[kName],
      workingDuration: json[kWorkingDuration],
      shortBreakDuration: json[kShortBreakDuration],
      longBreakDuration: json[kLongBreakDuration],
      moreInfo: json[kMoreInfo],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      kName: name,
      kWorkingDuration: workingDuration,
      kShortBreakDuration: shortBreakDuration,
      kLongBreakDuration: longBreakDuration,
      kMoreInfo: moreInfo,
    };
  }

  @override
  List<Object?> get props => [name, workingDuration, moreInfo];
}
