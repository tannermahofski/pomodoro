import 'package:flutter/material.dart';
import 'package:pomodoro_timer/helpers/constants/color_constants.dart';
import 'package:pomodoro_timer/home/widgets/prefix_icon.dart';
import 'package:pomodoro_timer/shared_models/task.dart';

class TaskContainer extends StatelessWidget {
  const TaskContainer({
    required this.task,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    super.key,
  });

  final Task task;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onDoubleTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      onDoubleTap: onDoubleTap,
      child: Padding(
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
                    //TODO: Alter leading image
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
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const PrefixIcon(
                  icon: Icon(Icons.play_arrow_rounded),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
