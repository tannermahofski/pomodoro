import 'package:flutter/material.dart';

class RoundedTextFieldWithLeadingIcon extends StatelessWidget {
  const RoundedTextFieldWithLeadingIcon({
    required this.hintText,
    this.obscureText = false,
    required this.onChanged,
    this.prefixIcon,
    super.key,
  });

  final String hintText;
  final bool obscureText;
  final Function(String) onChanged;
  final Icon? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: TextField(
        // autofocus: true,
        decoration: InputDecoration(
          // border: OutlineInputBorder(
          //   borderSide: const BorderSide(color: Colors.black),
          //   borderRadius: BorderRadius.circular(100),
          // ),
          prefixIcon: prefixIcon,
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodySmall,
        ),
        textAlign: TextAlign.center,
        obscureText: obscureText,
        style: Theme.of(context).textTheme.bodyMedium,
        onChanged: onChanged,
      ),
    );
  }
}
