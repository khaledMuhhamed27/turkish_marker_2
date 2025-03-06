import 'package:turkesh_marketer/api/cooperation_service.dart';
import 'package:turkesh_marketer/model/cooperations_model.dart';

class CooperationRespository {
  final CooperationService cooperationService;

  CooperationRespository(this.cooperationService);

  Future<List<CooperationsModel>> getCooperationsByType(String type) async {
    return cooperationService.getCooperationsByType(type);
  }
}
