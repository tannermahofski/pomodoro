import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({
    required this.condition,
    required this.errorMessage,
    super.key,
  });

  final bool condition;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: condition ? 1 : 0,
      child: Text(
        errorMessage,
        style:
            Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.red),
      ),
    );
  }
}
