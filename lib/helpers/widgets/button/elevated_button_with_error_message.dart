import 'package:flutter/material.dart';
import 'package:pomodoro_timer/helpers/widgets/button/elevated_button_with_padding.dart';
import 'package:pomodoro_timer/helpers/widgets/error_message.dart';

class ElevatedButtonWithErrorMessage extends StatelessWidget {
  const ElevatedButtonWithErrorMessage({
    required this.text,
    required this.onPress,
    this.padding = const EdgeInsets.all(10.0),
    required this.condition,
    required this.errorMessage,
    super.key,
  });

  final String text;
  final VoidCallback onPress;
  final EdgeInsets padding;
  final bool condition;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Center(
          child: ErrorMessage(
            condition: condition,
            errorMessage: errorMessage,
          ),
        ),
        ElevatedButtonWithPadding(
          text: text,
          onPress: onPress,
          padding: padding,
        ),
      ],
    );
  }
}
