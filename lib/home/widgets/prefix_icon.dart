import 'package:flutter/material.dart';
import 'package:pomodoro_timer/helpers/constants/color_constants.dart';

class PrefixIcon extends StatelessWidget {
  const PrefixIcon({
    required this.icon,
    this.size = 40.0,
    super.key,
  });

  final Icon icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kVioletBlue,
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
