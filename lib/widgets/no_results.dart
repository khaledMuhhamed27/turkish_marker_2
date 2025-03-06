import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NoResultsWidget extends StatelessWidget {
  const NoResultsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 100),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                border: Border.all(
                  width: 1,
                  color: Color(0xFFEAECF0),
                )),
            child: SvgPicture.asset("assets/images/srch.svg"),
          ),
          SizedBox(height: 20),
          AutoSizeText(
            "There are no items yet",
            style: TextStyle(fontSize: 20, color: Color(0xFF475467)),
          )
        ],
      ),
    );
  }
}
