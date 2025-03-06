class Category {
  final int id;
  final String? icon;
  final String name;
  final String description;
  final int? parentId;

  Category({
    required this.id,
    this.icon,
    required this.name,
    required this.description,
    this.parentId,
  });

  // Factory method لتحويل JSON إلى كائن Category
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0, // إذا كانت null، نعيد 0
      icon: json['icon'], // إذا كانت null، نعيد null
      name: json['name'] ?? '', // إذا كانت null، نعيد اسم فارغ
      description: json['description'] ?? '', // إذا كانت null، نعيد وصف فارغ
      parentId: json['parent_id'], // يمكن أن يكون null
    );
  }

  // دالة toString لتسهيل تصحيح الأخطاء
  @override
  String toString() {
    return 'Category(id: $id, name: $name, description: $description, parentId: $parentId, icon: $icon)';
  }
}

// موديل شامل يحتوي على قائمة الفئات والإحصائيات
class CategoryResponse {
  final List<Category> categories;
  final int countCategories;
  final int countSubCategories;

  CategoryResponse({
    required this.categories,
    required this.countCategories,
    required this.countSubCategories,
  });

  // Factory method لتحويل JSON إلى كائن CategoryResponse
  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      categories: (json['categories'] as List?)
              ?.map((categoryJson) =>
                  Category.fromJson(categoryJson as Map<String, dynamic>))
              .toList() ??
          [], // إذا كانت `null`، نُرجع قائمة فارغة
      countCategories: json['count_categories'] ?? 0,
      countSubCategories: json['count_sub_categories'] ?? 0,
    );
  }

  // دالة toString لتسهيل تصحيح الأخطاء
  @override
  String toString() {
    return 'CategoryResponse(countCategories: $countCategories, countSubCategories: $countSubCategories, categories: $categories)';
  }
}
