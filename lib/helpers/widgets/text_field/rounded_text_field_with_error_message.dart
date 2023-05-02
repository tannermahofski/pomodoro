import 'package:flutter/material.dart';
import 'package:pomodoro_timer/helpers/widgets/text_field/rounded_text_field_with_leading_icon.dart';
import 'package:pomodoro_timer/helpers/widgets/error_message.dart';

class RoundedTextFieldWithErrorMessage extends StatelessWidget {
  const RoundedTextFieldWithErrorMessage({
    required this.hintText,
    this.prefixIcon,
    this.obscureText = false,
    required this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.textEditingController,
    required this.errorCondition,
    required this.errorMessage,
    super.key,
  });

  final String hintText;
  final Widget? prefixIcon;
  final bool obscureText;
  final Function(String) onChanged;
  final VoidCallback? onTap;
  final bool readOnly;
  final TextEditingController? textEditingController;
  final bool errorCondition;
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
          onTap: onTap,
          readOnly: readOnly,
          textEditingController: textEditingController,
          prefixIcon: prefixIcon,
          obscureText: obscureText,
        ),
        ErrorMessage(condition: errorCondition, errorMessage: errorMessage)
      ],
    );
  }
}
