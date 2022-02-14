import 'package:flutter/material.dart';

class ErrorState extends StatelessWidget {
  final String error;
  const ErrorState({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Simple error screen
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        error,
        style: const TextStyle(color: Colors.red, fontSize: 24),
      ),
    );
  }
}
