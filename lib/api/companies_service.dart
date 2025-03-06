import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:turkesh_marketer/constants/helpers.dart';
import 'package:turkesh_marketer/model/compaines_model.dart';
import 'package:http/http.dart' as http;

class CompaniesService {
  Future<List<CompaniesModel>> getAllCompanies() async {
    const String url = "https://turkish.weblayer.info/api/v1.0/companies";

    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        debugPrint("✅ استجابة ناجحة - رمز الحالة: ${response.statusCode}");

        try {
          final decodedData = json.decode(response.body);

          if (decodedData is List) {
            return decodedData
                .map((jsonImport) => CompaniesModel.fromJson(jsonImport))
                .toList();
          } else {
            debugPrint(
                "⚠️ البيانات المسترجعة ليست من النوع المتوقع: $decodedData");
            return [];
          }
        } catch (jsonError) {
          debugPrint("❌ خطأ في فك ترميز JSON: $jsonError");
          return [];
        }
      } else {
        // 🔴 تحويل الخطأ إلى رسالة واضحة
        final decodedError = json.decode(response.body);
        String errorMessage = transformErrors(decodedError);
        debugPrint("❌ خطأ HTTP: $errorMessage");

        return [];
      }
    } catch (e) {
      debugPrint("❌ حدث خطأ أثناء جلب البيانات: $e");
      return [];
    }
  }
}
