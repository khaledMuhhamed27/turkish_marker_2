class CooperationsModel {
  final int id;
  final String? countryId;
  final String type;
  final String title;
  final String details;
  final String? categoreyId;
  final String? parentId;
  final String? cooperationSubtype;
  final String? tenderSubtype;
  final String? companynameText;
  final int companyId;
  final String photo;
  final String createdAt;
  final String typeText;
  final int credit;

  CooperationsModel({
    required this.id,
    this.countryId,
    required this.type,
    required this.title,
    required this.details,
    this.categoreyId,
    this.parentId,
    this.cooperationSubtype,
    this.tenderSubtype,
    this.companynameText,
    required this.companyId,
    required this.photo,
    required this.createdAt,
    required this.typeText,
    required this.credit,
  });

  factory CooperationsModel.fromJson(Map<String, dynamic> json) {
    return CooperationsModel(
      id: json['id'] ?? 0,
      countryId: json['country_id']?.toString(),
      type: json['type'] ?? '',
      title: json['title'] ?? '',
      details: json['details'] ?? '',
      categoreyId: json['categorey_id']?.toString(),
      parentId: json['parent_id']?.toString(),
      cooperationSubtype: json['cooperation_subtype'],
      tenderSubtype: json['tender_subtype'],
      companynameText: json['companyname_text'],
      companyId: json['company_id'] ?? 0,
      photo: json['photo'] ?? '',
      createdAt: json['created_at'] ?? '',
      typeText: json['type_text'] ?? '',
      credit: json['credit'] ?? 0,
    );
  }
}
