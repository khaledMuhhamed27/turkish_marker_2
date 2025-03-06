import 'package:turkesh_marketer/api/categories_service.dart';
import 'package:turkesh_marketer/model/categories_modell.dart';

class CategoryRepository {
  final CategoryApiService apiService;

  CategoryRepository({required this.apiService});

  Future<CategoryResponse> getCategories() async {
    return await apiService.fetchCategories();
  }

  Future<List<Category>> getSubcategories(int parentId) async {
    return await apiService.fetchSubcategories(parentId);
  }
}
