import 'package:easy_localization/easy_localization.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:turkesh_marketer/model/compaines_model.dart';
import 'package:turkesh_marketer/widgets/import_container.dart';

class ShowDetailsCompany extends StatelessWidget {
  // ✅ استقبل عنصر واحد فقط
  final CompaniesModel companiesModel;
  const ShowDetailsCompany({
    super.key,
    required this.companiesModel,
  });
  final String baseUrl = "https://turkish.weblayer.info/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(companiesModel.title)), // ✅ عرض عنوان العنصر المحدد
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Card
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFD0D5DD), width: 1),
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: companiesModel.photo.isNotEmpty
                        ? FancyShimmerImage(
                            imageUrl: companiesModel.photo,
                            boxFit: BoxFit.fill,
                          )
                        : FancyShimmerImage(
                            // ignore: unnecessary_null_comparison
                            imageUrl: companiesModel.photo != null
                                ? baseUrl + companiesModel.photo
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
                  const SizedBox(height: 10),
                  ImportContainer(importType: companiesModel.typeText),
                  const SizedBox(height: 5),
                  Text(
                    companiesModel.title, // ✅ عرض العنوان الصحيح
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFD0D5DD)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/images/setting.svg"),
                            SizedBox(width: 5),
                            Text(
                              "mano".tr(), // ✅ عرض الرصيد
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF344054),
                                  decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFD0D5DD)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            // ignore: deprecated_member_use
                            SvgPicture.asset(
                              "assets/images/lrf.svg",
                              color: Colors.teal,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "expo".tr(), // ✅ عرض الرصيد
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF344054),
                                  decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // SizedBox
            SizedBox(height: 4),
            // Divider 1
            Divider(
              thickness: 1,
              color: Color(0xFFD0D5DD),
            ),
            // Title Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFD0D5DD),
                  ),
                  borderRadius: BorderRadius.circular(12)),
              child: Text(
                "aslanlar".tr(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            // Divider 2
            Divider(
              thickness: 1,
              color: Color(0xFFD0D5DD),
            ),
            // Sized
            SizedBox(height: 20),
            // Contact Information Card
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFFD0D5DD))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "contact_for".tr(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      // Circolar
                      SvgPicture.asset("assets/images/crclo.svg"),
                      // Sized
                      SizedBox(width: 10),
                      // 2 text
                      Column(
                        children: [
                          Text(
                            "Company",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            companiesModel.title,
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF475467),
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            // Products Card
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFFD0D5DD))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "product".tr(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  // Sized
                  SizedBox(height: 30),
                ],
              ),
            ),
            SizedBox(height: 200),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(0.0),
        child: MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          height: 44,
          minWidth: MediaQuery.of(context).size.width * 0.92,
          color: Color(0xff475467),
          onPressed: () {
            print("Buy a plan");
          },
          child: Text(
            "Buy a plan",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
