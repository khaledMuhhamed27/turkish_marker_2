import 'package:flutter/material.dart';

class LoadingWidgt extends StatelessWidget {
  const LoadingWidgt({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: CircularProgressIndicator(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.red,
        ),
      ),
    );
  }
}
