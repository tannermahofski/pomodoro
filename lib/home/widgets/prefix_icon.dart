import 'package:flutter/material.dart';
import 'package:pomodoro_timer/helpers/constants/color_constants.dart';

class PrefixIcon extends StatelessWidget {
  const PrefixIcon({
    required this.icon,
    this.size = 40.0,
    this.color = kVioletBlue,
    super.key,
  });

  final Icon icon;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: size,
        height: size,
        child: Icon(
          icon.icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
