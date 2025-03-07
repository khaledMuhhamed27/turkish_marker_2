import 'package:turkesh_marketer/api/search_service.dart';
import 'package:turkesh_marketer/model/search_model.dart';

class SearchRepository {
  final SearchService _searchService;

  SearchRepository(this._searchService);

  Future<SearchResult> search(String query) async {
    try {
      // طلب البيانات من الخدمة
      return await _searchService.search(query);
    } catch (e) {
      // إذا حدث خطأ في جلب البيانات من الخدمة، قم برمي استثناء
      throw Exception('فشل في جلب نتائج البحث: $e');
    }
  }
}
