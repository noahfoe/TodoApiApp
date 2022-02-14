import 'package:flutter/material.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Simple loading animation
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
