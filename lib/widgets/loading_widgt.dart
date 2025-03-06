import 'package:flutter/material.dart';

class LoadingWidgt extends StatelessWidget {
  const LoadingWidgt({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.red,
      ),
    );
  }
}
