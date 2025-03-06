import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:turkesh_marketer/model/import_model.dart';

class ImportService {
  final String baseUrl = "https://turkish.weblayer.info/api/v1.0/posts/";

  Future<List<ImportModel>> getImportsByType(String type) async {
    final String url = "$baseUrl$type";
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        if (decodedData is List) {
          return decodedData.map((json) => ImportModel.fromJson(json)).toList();
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
