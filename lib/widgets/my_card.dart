import 'package:easy_localization/easy_localization.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:turkesh_marketer/model/compaines_model.dart';
import 'package:turkesh_marketer/widgets/import_container.dart';

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
                  "sponsor".tr(),
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
            height: 300,
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
            margin: EdgeInsets.only(
              right: 12,
              left: 12,
              top: 12,
              bottom: 0,
            ),
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
                    height: 176,
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
                                fit: BoxFit.fill,
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
                        "sponsor".tr(),
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
                  height: 100,
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
      padding: EdgeInsets.only(right: 8, left: 8, top: 10, bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImportContainer(
              importType: companyModel.cooperationSubtype.toString()),
          SizedBox(height: 10),
          Text(
            companyModel.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}
