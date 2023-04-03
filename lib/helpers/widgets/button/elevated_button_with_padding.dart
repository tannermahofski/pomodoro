import 'package:flutter/material.dart';

class ElevatedButtonWithPadding extends StatelessWidget {
  const ElevatedButtonWithPadding({
    required this.text,
    required this.onPress,
    this.padding = const EdgeInsets.all(10.0),
    super.key,
  });

  final String text;
  final EdgeInsets padding;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ElevatedButton(
        onPressed: onPress,
        child: Text(text),
      ),
    );
  }
}
