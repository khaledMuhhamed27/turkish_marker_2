import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:turkesh_marketer/model/search_model.dart';

class SearchService {
  static const String _baseUrl =
      'https://turkish.weblayer.info/api/v1.0/search';

  Future<SearchResult> search(String query) async {
    final Uri uri = Uri.parse('$_baseUrl?search_key=all&text=$query');
    final response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // إذا كانت الاستجابة ناجحة (رمز الحالة 200)
      return SearchResult.fromJson(json.decode(response.body));
    } else {
      // في حال حدوث خطأ
      throw Exception('فشل تحميل البيانات من الـ API');
    }
  }
}
