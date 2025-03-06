class CompaniesModel {
  final int id;
  final int userId;
  final String? countryId;
  final String status;
  final String title;
  final String details;
  final String? categoryId;
  final String? parentId;
  final String? cooperationSubtype;
  final String tenderSubtype;
  final String? companynameText;
  final int companyId;
  final String photo;
  final DateTime createdAt;
  final String typeText;
  final int isSponsored; // ✅ تمت إضافته

  CompaniesModel({
    required this.id,
    required this.userId,
    this.countryId,
    required this.status,
    required this.title,
    required this.details,
    this.categoryId,
    this.parentId,
    this.cooperationSubtype,
    required this.tenderSubtype,
    this.companynameText,
    required this.companyId,
    required this.photo,
    required this.createdAt,
    required this.typeText,
    required this.isSponsored, // ✅ تمت إضافته
  });

  // ✅ تحويل JSON إلى كائن Dart
  factory CompaniesModel.fromJson(Map<String, dynamic> json) {
    return CompaniesModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      countryId: json['country_id']?.toString(),
      status: json['status'] ?? 'Unknown',
      title: json['title'] ?? 'No Title',
      details: json['profile']?['details'] ?? 'No Details',
      categoryId: json['categorey_id']?.toString(),
      parentId: json['parent_id']?.toString(),
      cooperationSubtype: json['company_type_id']?.toString(),
      tenderSubtype: 'General', // ❗لا يوجد في البيانات، وضعنا قيمة افتراضية
      companynameText:
          json['title'], // ❗استخدمنا العنوان لأنه لا يوجد companyname_text
      companyId: json['id'] ?? 0, // ❗استخدمنا id لأنه لا يوجد company_id
      photo: json['photo'] != null
          ? "https://turkish.weblayer.info/${json['photo']}"
          : "", // ✅ معالجة الصورة
      createdAt:
          DateTime.now(), // ❗لا يوجد تاريخ في الـ API، استخدمنا التاريخ الحالي
      typeText: json['company_type_id'] ?? 'Unknown', // ❗استخدمنا نوع الشركة

      isSponsored: json['is_sponsored'] ?? 0, // ✅ تمت إضافته من الـ API
    );
  }

  // ✅ تحويل كائن Dart إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      if (countryId != null) 'country_id': countryId,
      'status': status,
      'title': title,
      'details': details,
      if (categoryId != null) 'categorey_id': categoryId,
      if (parentId != null) 'parent_id': parentId,
      if (cooperationSubtype != null) 'company_type_id': cooperationSubtype,
      'tender_subtype': tenderSubtype,
      if (companynameText != null) 'companyname_text': companynameText,
      'company_id': companyId,
      'photo': photo,
      'created_at': createdAt.toIso8601String(),
      'type_text': typeText,
      'is_sponsored': isSponsored, // ✅ تمت إضافته
    };
  }
}
