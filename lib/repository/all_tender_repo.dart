import 'package:turkesh_marketer/api/tender_service.dart';
import 'package:turkesh_marketer/model/tender_model.dart';

class TenderRepository {
  final TenderService _tenderService;

  TenderRepository(this._tenderService);

  /// جلب جميع العطاءات
  Future<List<Tender>> fetchTenders() async {
    return await _tenderService.getAllTenders();
  }

  /// جلب العطاءات بناءً على `tender_subtype`
  Future<List<Tender>> fetchTendersBySubtype(String subtype) async {
    return await _tenderService.getTendersBySubtype(subtype);
  }
}
