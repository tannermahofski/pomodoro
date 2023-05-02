import 'package:flutter/material.dart';

class RoundedTextFieldWithLeadingIcon extends StatelessWidget {
  const RoundedTextFieldWithLeadingIcon({
    required this.hintText,
    this.obscureText = false,
    required this.onChanged,
    this.prefixIcon,
    this.textEditingController,
    this.onTap,
    this.readOnly = false,
    super.key,
  });

  final String hintText;
  final bool obscureText;
  final Function(String) onChanged;
  final Widget? prefixIcon;
  final TextEditingController? textEditingController;
  final VoidCallback? onTap;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: TextField(
        readOnly: readOnly,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.color
                    ?.withOpacity(0.8),
              ),
        ),
        textAlign: TextAlign.center,
        obscureText: obscureText,
        style: Theme.of(context).textTheme.bodyMedium,
        onChanged: onChanged,
        onTap: onTap,
        controller: textEditingController,
      ),
    );
  }
}
