import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

class ShimerImageUrl extends StatelessWidget {
  final String myImageUrl;
  const ShimerImageUrl({super.key, required this.myImageUrl});

  @override
  Widget build(BuildContext context) {
    return FancyShimmerImage(
        errorWidget: Icon(
          Icons.align_vertical_center,
          color: Colors.red,
        ),
        imageUrl: myImageUrl);
  }
}
