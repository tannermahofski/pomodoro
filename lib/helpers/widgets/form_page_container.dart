import 'package:flutter/material.dart';

class FomPageContainer extends StatelessWidget {
  final List<Widget> children;
  const FomPageContainer({required this.children, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: children,
          ),
        ),
      ),
    );
  }
}
