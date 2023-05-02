import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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
        padding: const EdgeInsets.all(8.0),
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
                LeadingWidget(task: task),
                const CircleAvatar(
                  backgroundColor: kVioletBlue,
                  child: Icon(MdiIcons.chevronRight, color: Colors.white),
                ),
                // const Icon(MdiIcons.chevronRight),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LeadingWidget extends StatelessWidget {
  const LeadingWidget({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //TODO: Alter leading image
        // const Icon(MdiIcons.calendarCheck),
        const PrefixIcon(
          icon: Icon(MdiIcons.calendarCheck),
          color: kAppleGreen,
        ),
        TaskContainerText(task: task),
      ],
    );
  }
}

class TaskContainerText extends StatelessWidget {
  const TaskContainerText({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              task.name,
              style: Theme.of(context).textTheme.headlineSmall,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              task.moreInfo,
              style: Theme.of(context).textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
