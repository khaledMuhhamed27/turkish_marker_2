import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:turkesh_marketer/constants/base_url.dart';

// ignore: must_be_immutable
class CartegoryCard extends StatelessWidget {
  String? title;
  String? subtitle;
  String? imageUrl;
  void Function()? onTap;
  CartegoryCard(
      {super.key,
      this.imageUrl,
      this.subtitle,
      this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      alignment: Alignment.center,
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black54
                  : Color(0xFFF9FAF5),
              width: 1),
        ),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.black54
              : Color(0xFFFEE4E2),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: FancyShimmerImage(
                imageUrl: imageUrl != null ? baseUrl + imageUrl! : "",
                errorWidget: Image.network(
                  "${baseUrl}imgs/adminrequest_photo/BjzEOvaa4NZgZJcjTJYmc1ehXHAyygDqXYQdEOBi.jpg",
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image,
                        size: 50, color: Colors.grey);
                  },
                ),
              )),
        ),
        tileColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black54
            : Color(0xFFF9FAFB),
        onTap: onTap,
        title: Text(
          title.toString(),
          style: const TextStyle(
            color: Color(0xFF667085),
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle.toString(), // جلب الوصف من ملف الترجمة
          maxLines: 2,
          style: const TextStyle(color: Color(0xFF475467)),
        ),
      ),
    );
  }
}
