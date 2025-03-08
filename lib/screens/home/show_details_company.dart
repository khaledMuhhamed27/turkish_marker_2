import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:turkesh_marketer/model/compaines_model.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
              const SizedBox(height: 16),
              Text(
                companiesModel.title, // ✅ عرض العنوان الصحيح
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.visibility),
                        SizedBox(width: 5),
                        Text("0 views"), // ✅ يمكنك تحسينه لاحقًا
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(children: [
                      Icon(Icons.calendar_today),
                      SizedBox(width: 5),
                      Text(
                        DateFormat('yyyy-MM-dd').format(DateTime.parse(
                            companiesModel.createdAt.toString())),
                      ),
                    ]),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  SvgPicture.asset("assets/images/cikl.svg"),
                  Text(
                    "${companiesModel.parentId} Credits", // ✅ عرض الرصيد
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF475467),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(companiesModel.details,
                  style: const TextStyle(fontSize: 16)), // ✅ عرض التفاصيل
              SizedBox(height: 150),
            ],
          ),
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
