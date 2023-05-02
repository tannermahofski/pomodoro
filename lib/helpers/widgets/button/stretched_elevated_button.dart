import 'package:flutter/material.dart';

class StretchedElevatedButton extends StatelessWidget {
  const StretchedElevatedButton({
    required this.onPressed,
    required this.child,
    super.key,
  });

  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: SizedBox(
        width: double.infinity,
        child: Center(child: child),
      ),
    );
  }
}
