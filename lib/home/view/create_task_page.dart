import 'package:flutter/material.dart';

class CreateTaskPage extends StatelessWidget {
  static Route<void> route() =>
      MaterialPageRoute(builder: (_) => const CreateTaskPage());

  const CreateTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // actions: [
          //   IconButton(
          //     icon: const Icon(Icons.arrow_back),
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //   )
          // ],
          ),
    );
  }
}
