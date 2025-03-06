import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimerWidgetImpt extends StatelessWidget {
  const ShimerWidgetImpt({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: 140,
        margin: EdgeInsets.all(12),
        child: Row(
          children: [
            // img
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            // text
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 10,
                    color: Colors.grey.shade300,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Container(
                    height: 10,
                    color: Colors.grey.shade300,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
