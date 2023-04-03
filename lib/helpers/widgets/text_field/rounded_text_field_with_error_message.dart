import 'package:flutter/material.dart';
import 'package:pomodoro_timer/helpers/widgets/text_field/rounded_text_field_with_leading_icon.dart';
import 'package:pomodoro_timer/helpers/widgets/error_message.dart';

class RoundedTextFieldWithErrorMessage extends StatelessWidget {
  const RoundedTextFieldWithErrorMessage({
    required this.hintText,
    this.prefixIcon,
    this.obscureText = false,
    required this.onChanged,
    required this.condition,
    required this.errorMessage,
    super.key,
  });

  final String hintText;
  final Icon? prefixIcon;
  final bool obscureText;
  final Function(String) onChanged;
  final bool condition;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        RoundedTextFieldWithLeadingIcon(
          hintText: hintText,
          onChanged: onChanged,
          prefixIcon: prefixIcon,
          obscureText: obscureText,
        ),
        ErrorMessage(condition: condition, errorMessage: errorMessage)
      ],
    );
  }
}
