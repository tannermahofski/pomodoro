import 'package:flutter/material.dart';
import 'package:pomodoro_timer/helpers/constants/color_constants.dart';
import 'package:pomodoro_timer/home/widgets/prefix_icon.dart';
import 'package:pomodoro_timer/shared_models/task.dart';

class TaskContainer extends StatelessWidget {
  final Task task;
  const TaskContainer({required this.task, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(10),
        shadowColor: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //TODO: Maybe some kind of leading image
                  const CircleAvatar(
                    backgroundColor: kVioletBlue,
                    child: Icon(Icons.check),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          task.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          task.workingDuration,
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              // CircleAvatar(
              //   child: Icon(
              //     // Icons.chevron_right_sharp,
              //     Icons.play_arrow_rounded,
              //     color: Theme.of(context).iconTheme.color,
              //   ),
              // )
              const PrefixIcon(icon: Icon(Icons.play_arrow_rounded)),
            ],
          ),
        ),
      ),
    );
  }
}
