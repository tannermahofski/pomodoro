import 'package:flutter/material.dart';
import 'package:pomodoro_timer/shared_models/task.dart';

class EditTaskPage extends StatelessWidget {
  static Route<void> route(Task task) => MaterialPageRoute(
        builder: (context) => EditTaskPage(task: task),
      );

  const EditTaskPage({
    required Task task,
    super.key,
  }) : _task = task;

  final Task _task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit page'),
      ),
    );
  }
}
