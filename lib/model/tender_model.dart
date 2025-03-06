class Tender {
  final int id;
  final String? countryId;
  final String type;
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
  final int credit;

  Tender({
    required this.id,
    this.countryId,
    required this.type,
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
    required this.credit,
  });

  // ✅ تحويل JSON إلى كائن Dart
  factory Tender.fromJson(Map<String, dynamic> json) {
    return Tender(
      id: json['id'] ?? 0,
      countryId: json['country_id']?.toString(),
      type: json['type'] ?? 'Unknown',
      title: json['title'] ?? 'No Title',
      details: json['details'] ?? 'No Details',
      categoryId: json['categorey_id']?.toString(), // ✅ إصلاح الخطأ الإملائي
      parentId: json['parent_id']?.toString(),
      cooperationSubtype: json['cooperation_subtype']?.toString(),
      tenderSubtype: json['tender_subtype'] ?? 'Unknown',
      companynameText: json['companyname_text']?.toString(),
      companyId: json['company_id'] ?? 0,
      photo: json['photo'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ??
          DateTime(2000, 1, 1), // ✅ تحويل إلى DateTime
      typeText: json['type_text'] ?? 'Unknown',
      credit: json['credit'] ?? 0,
    );
  }

  // ✅ تحويل كائن Dart إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      if (countryId != null) 'country_id': countryId,
      'type': type,
      'title': title,
      'details': details,
      if (categoryId != null) 'categorey_id': categoryId,
      if (parentId != null) 'parent_id': parentId,
      if (cooperationSubtype != null) 'cooperation_subtype': cooperationSubtype,
      'tender_subtype': tenderSubtype,
      if (companynameText != null) 'companyname_text': companynameText,
      'company_id': companyId,
      'photo': photo,
      'created_at': createdAt.toIso8601String(), // ✅ تحسين التحويل إلى JSON
      'type_text': typeText,
      'credit': credit,
    };
  }
}
