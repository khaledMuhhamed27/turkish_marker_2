import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:turkesh_marketer/model/show_select_categ_model.dart';

class PostService {
  static const String _baseUrl =
      'https://turkish.weblayer.info/api/v1.0/posts?parent_id=';

  // دالة لجلب البوستات حسب parent_id
  Future<List<Post>> fetchPostsByParentId(String parentId) async {
    final Uri url = Uri.parse('$_baseUrl$parentId');
    print(url);
    if (parentId.isEmpty || parentId == 'null') {
      throw Exception('الـ parentId غير صالحة');
    }
    try {
      final response = await http.get(
        url,
        headers: {'accept': 'application/json'},
      );
      print("StaTusForCategories${response.statusCode}");

      // إذا كانت الاستجابة ناجحة (statusCode = 200)
      if (response.statusCode == 200) {
        // تحويل الاستجابة من JSON إلى قائمة من Post
        List<dynamic> data = json.decode(response.body);

        // تأكد من أن البيانات هي قائمة من العناصر
        return data.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('فشل في تحميل البيانات');
      }
    } catch (e) {
      throw Exception('حدث خطأ: $e');
    }
  }
}
