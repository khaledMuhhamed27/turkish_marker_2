import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:turkesh_marketer/model/compaines_model.dart';

// ignore: must_be_immutable
class MyProfCard extends StatefulWidget {
  final CompaniesModel companiesModel;
  void Function()? onTap;
  MyProfCard({super.key, required this.companiesModel, this.onTap});

  @override
  State<MyProfCard> createState() => _MyProfCardState();
}

class _MyProfCardState extends State<MyProfCard> {
  final String baseUrl = "https://turkish.weblayer.info/";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // ✅ الشريط الأحمر - يظهر خلف البطاقة
          if (widget.companiesModel.isSponsored == 1)
            Positioned(
              top: 35,
              left: -10,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 13),
                width: 200,
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Sponsored",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          // ✅ البطاقة الرئيسية
          Container(
            height: 358,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              border: Border.all(
                width: 1,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade800
                    : Color(0xFFEAECF0),
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            margin: EdgeInsets.all(12),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // ✅ صورة الشركة
                Positioned(
                  top: 10,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 152,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: widget.companiesModel.photo.isNotEmpty
                          ? FancyShimmerImage(
                              imageUrl: widget.companiesModel.photo,
                              boxFit: BoxFit.cover,
                            )
                          : FancyShimmerImage(
                              // ignore: unnecessary_null_comparison
                              imageUrl: widget.companiesModel.photo != null
                                  ? baseUrl + widget.companiesModel.photo
                                  : "",
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
                ),

                // ✅ الشريط الأمامي - فقط إذا كان Sponsored
                if (widget.companiesModel.isSponsored == 1)
                  Positioned(
                    top: 20,
                    left: -15,
                    child: Container(
                      width: 120,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Sponsored",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                // ✅ المعلومات النصية
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 12,
                  height: 150,
                  child: TextsContainer(
                    companyModel: widget.companiesModel,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ✅ ويدجت عرض المعلومات
class TextsContainer extends StatelessWidget {
  final CompaniesModel companyModel;

  const TextsContainer({super.key, required this.companyModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            companyModel.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          SizedBox(height: 5),
          Text(
            companyModel.details,
            style: TextStyle(color: Colors.grey[600]),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Icon(Icons.location_on, size: 16, color: Colors.grey),
              SizedBox(width: 4),
              Text(
                companyModel.status,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Icon(Icons.category, size: 16, color: Colors.grey),
              SizedBox(width: 4),
              Text(
                '#${companyModel.createdAt}',
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
