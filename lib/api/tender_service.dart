import 'dart:convert';

import 'package:turkesh_marketer/model/tender_model.dart';
import 'package:http/http.dart' as http;

class TenderService {
  static const String baseUrl =
      "https://turkish.weblayer.info/api/v1.0/posts/tender";

  /// جلب جميع العطاءات (بدون تصنيف)
  Future<List<Tender>> getAllTenders() async {
    return _fetchTendersFromApi(null);
  }

  /// جلب العطاءات بناءً على `tender_subtype`
  Future<List<Tender>> getTendersBySubtype(String subtype) async {
    return _fetchTendersFromApi(subtype);
  }

  /// الدالة الأساسية التي تجلب البيانات من API
  Future<List<Tender>> _fetchTendersFromApi(String? subtype) async {
    print("Started");
    try {
      final String url = subtype != null ? "$baseUrl/$subtype" : baseUrl;
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);

        if (decodedData is List) {
          return decodedData
              .map((jsonTender) => Tender.fromJson(jsonTender))
              .toList();
        } else {
          throw Exception("البيانات المسترجعة ليست من النوع المتوقع");
        }
      } else {
        throw Exception(
            "فشل في تحميل البيانات، رمز الخطأ: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("حدث خطأ أثناء جلب البيانات: $e");
    }
  }
}
