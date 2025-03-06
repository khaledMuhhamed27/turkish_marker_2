import 'package:turkesh_marketer/api/request_service.dart';
import 'package:turkesh_marketer/model/import_model.dart';

class ImportRepository {
  final ImportService apiService;

  ImportRepository(this.apiService);

  Future<List<ImportModel>> getImportsByType(String type) async {
    return apiService.getImportsByType(type);
  }
}
