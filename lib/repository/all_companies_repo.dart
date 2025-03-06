import 'package:flutter/foundation.dart';
import 'package:turkesh_marketer/api/companies_service.dart';
import 'package:turkesh_marketer/model/compaines_model.dart';

class CompaniesRepository {
  final CompaniesService _service = CompaniesService();

  /// 🔥 جلب جميع الشركات مع التعامل مع الأخطاء
  Future<List<CompaniesModel>> fetchCompanies() async {
    try {
      final companies = await _service.getAllCompanies();
      return companies;
    } catch (e) {
      debugPrint("❌ خطأ في CompaniesRepository: $e");
      return [];
    }
  }
}
