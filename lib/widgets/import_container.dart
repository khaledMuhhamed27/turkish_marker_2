import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class ImportContainer extends StatelessWidget {
  String importType;
  ImportContainer({super.key, required this.importType});
  @override
  Widget build(BuildContext context) {
    return getImportText(importType, context);
  }

  Widget getImportText(String? importType, BuildContext context) {
    if (importType != null && importType.trim().isNotEmpty) {
      String firstWord =
          importType.trim().split(' ').first; // ✅ استخراج أول كلمة فقط

      if (firstWord.toLowerCase() != "null") {
        return IntrinsicWidth(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 25,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Color(0xFF333333)
                  : Color(0xFFFEF3F2),
              border: Border.all(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.teal
                    : Color(0xFFFECDCA),
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              firstWord, // ✅ استخدام أول كلمة فقط
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.teal
                    : Color(0xFFB42318),
              ),
            ),
          ),
        );
      }
    }
    return SizedBox(); // ✅ إذا كانت القيم غير صالحة، لا يعرض أي شيء
  }
}
