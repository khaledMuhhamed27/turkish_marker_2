import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:turkesh_marketer/model/tender_model.dart';

class ShowDetailsScreen extends StatelessWidget {
  final Tender tender;

  const ShowDetailsScreen({super.key, required this.tender});
  final String baseUrl = "https://turkish.weblayer.info/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tender.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(color: Colors.amber),
                child: FancyShimmerImage(
                    boxFit: BoxFit.fill,
                    errorWidget: Image.network(
                      "${baseUrl}imgs/adminrequest_photo/BjzEOvaa4NZgZJcjTJYmc1ehXHAyygDqXYQdEOBi.jpg",
                    ),
                    imageUrl: baseUrl + tender.photo),
              ),
              const SizedBox(height: 16),
              Text(
                tender.title,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  // View
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.visibility),
                        SizedBox(width: 5),
                        Text("0 views"),
                      ],
                    ),
                  ),
                  // Date
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today),
                        SizedBox(width: 5),
                        Text(
                          DateFormat('yyyy-MM-dd').format(
                              DateTime.parse(tender.createdAt.toString())),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Credits
              SizedBox(height: 20),
              Row(
                children: [
                  SvgPicture.asset("assets/images/cikl.svg"),
                  Text(
                    " ${tender.credit} Credits",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF475467),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(tender.details, style: const TextStyle(fontSize: 16)),
              SizedBox(height: 150),
            ],
            //
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
            print("object");
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
