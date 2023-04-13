import 'package:flutter/material.dart';
import 'package:pomodoro_timer/helpers/widgets/text_field/rounded_text_field_with_leading_icon.dart';
import 'package:pomodoro_timer/helpers/widgets/error_message.dart';

class RoundedTextFieldWithErrorMessage extends StatefulWidget {
  const RoundedTextFieldWithErrorMessage({
    required this.hintText,
    this.prefixIcon,
    this.obscureText = false,
    required this.onChanged,
    this.onTap,
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
  final TextEditingController? textEditingController;
  final bool errorCondition;
  final String errorMessage;

  @override
  State<RoundedTextFieldWithErrorMessage> createState() =>
      _RoundedTextFieldWithErrorMessageState();
}

class _RoundedTextFieldWithErrorMessageState
    extends State<RoundedTextFieldWithErrorMessage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        RoundedTextFieldWithLeadingIcon(
          hintText: widget.hintText,
          onChanged: widget.onChanged,
          textEditingController: widget.textEditingController,
          prefixIcon: widget.prefixIcon,
          obscureText: widget.obscureText,
        ),
        ErrorMessage(
            condition: widget.errorCondition, errorMessage: widget.errorMessage)
      ],
    );
  }

  @override
  void dispose() {
    widget.textEditingController?.dispose();
    super.dispose();
  }
}
