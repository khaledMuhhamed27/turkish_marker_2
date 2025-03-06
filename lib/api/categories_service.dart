import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:turkesh_marketer/model/categories_modell.dart';

class CategoryApiService {
  static const String baseUrl =
      "https://turkish.weblayer.info/api/v1.0/categories";

  Future<CategoryResponse> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        return CategoryResponse.fromJson(decodedData);
      } else {
        throw Exception(
            "فشل في تحميل البيانات، رمز الخطأ: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("حدث خطأ أثناء جلب البيانات: $e");
    }
  }

  // sub
  Future<List<Category>> fetchSubcategories(int parentId) async {
    try {
      String url =
          "https://turkish.weblayer.info/api/v1.0/subcategories/$parentId";
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        final List<dynamic>? subcategoriesData = decodedData['subcategories'];

        if (subcategoriesData == null) {
          print("⚠️ لا توجد فئات فرعية في الاستجابة!");
          return [];
        }

        print(
            "✅ البيانات المستلمة: $subcategoriesData"); // تتبع البيانات المستلمة

        return subcategoriesData
            .map((json) => Category.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception(
            'فشل في تحميل الفئات الفرعية، رمز الخطأ: ${response.statusCode}');
      }
    } catch (e) {
      print("❌ خطأ أثناء جلب الفئات الفرعية: $e");
      throw Exception("حدث خطأ أثناء جلب الفئات الفرعية: $e");
    }
  }
}
