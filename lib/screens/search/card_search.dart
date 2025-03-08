import 'package:auto_size_text/auto_size_text.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:turkesh_marketer/constants/base_url.dart';
import 'package:turkesh_marketer/constants/created_at_intl.dart';

// ignore: must_be_immutable
class MySearchCard extends StatelessWidget {
  final int? id;
  final String? imageUrl;
  final String title;
  final String? details;
  final String? importText;
  final int? credits;
  final String createdAt;
  void Function()? onTap;
  MySearchCard({
    super.key,
    this.onTap,
    this.id,
    this.imageUrl,
    required this.title,
    this.details,
    this.importText,
    this.credits,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          // border
          border: Border.all(
            color: Color(0xFFEAECF0),
            width: 1,
          ),
          // border Raduis
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image
            Container(
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.all(0),
              height: 100,
              width: 100,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FancyShimmerImage(
                  imageUrl: imageUrl != null ? baseUrl + imageUrl! : "",
                  errorWidget: Image.network(
                    "${baseUrl}imgs/adminrequest_photo/BjzEOvaa4NZgZJcjTJYmc1ehXHAyygDqXYQdEOBi.jpg",
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.broken_image,
                          size: 50, color: Colors.grey);
                    },
                  ),
                ),
              ),
            ),
            // Sized
            SizedBox(width: 10),
            // TEXTS
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      // 1 Container
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 25,
                        decoration: BoxDecoration(
                          color: Color(0xFFFEF3F2),
                          border: Border.all(
                            color: Color(0xFFFECDCA),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/images/arwob.svg"),
                            SizedBox(width: 8),
                            Text(
                              importText.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFB42318),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      // 2 Container
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 25,
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          border: Border.all(
                            color: Color(0xFFD0D5DD),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/images/arwob.svg"),
                            SizedBox(width: 8),
                            Text(
                              "Egypt",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF344054),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      // title
                      AutoSizeText(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                      ),
                      // discreption
                      AutoSizeText(
                        details.toString(),
                        maxLines: 2,
                      ),
                      // Sized
                      SizedBox(height: 8),
                      // # 2 TEXTS

                      // Sized
                      SizedBox(height: 8),

                      // # 2 TEXTS
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // # 1
                          Expanded(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .start, // محاذاة العناصر بشكل صحيح
                              children: [
                                // ICON
                                SvgPicture.asset("assets/images/cikl.svg"),
                                SizedBox(width: 5),
                                // TEXT
                                AutoSizeText(
                                  "$credits Credits",
                                  style: TextStyle(
                                      fontSize: 10), // تعديل الحجم حسب الحاجة
                                ),
                              ],
                            ),
                          ),

                          // # 2
                          Expanded(
                            flex: 3,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // جعل المحاذاة من الأعلى
                              children: [
                                // ICON
                                SvgPicture.asset("assets/images/clock.svg"),
                                SizedBox(width: 5),
                                // TEXT
                                Expanded(
                                  child: AutoSizeText(
                                    formatDate(createdAt),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
