import 'package:flutter/material.dart';

class LoginPageButton extends StatelessWidget {
  final String text;
  final EdgeInsets padding;
  final VoidCallback onPress;

  const LoginPageButton({
    required this.text,
    required this.onPress,
    this.padding = const EdgeInsets.all(10.0),
    super.key,
  });

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
