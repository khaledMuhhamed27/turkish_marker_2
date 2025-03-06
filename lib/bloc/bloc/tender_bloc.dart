import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkesh_marketer/bloc/bloc/tender_event.dart';
import 'package:turkesh_marketer/bloc/bloc/tender_state.dart';
import 'package:turkesh_marketer/model/tender_model.dart';
import 'package:turkesh_marketer/repository/all_tender_repo.dart';

// Bloc Class

class TenderBloc extends Bloc<TenderEvent, TenderState> {
  final TenderRepository _tenderRepository;

  TenderBloc(this._tenderRepository) : super(TenderLoading()) {
    // تسجيل المعالج للحدث
    on<LoadTendersEvent>((event, emit) async {
      emit(TenderLoading()); // عندما يبدأ تحميل العطاءات
      try {
        List<Tender> tenders;
        if (event.tenderSubtype != null) {
          tenders = await _tenderRepository
              .fetchTendersBySubtype(event.tenderSubtype!);
        } else {
          tenders = await _tenderRepository.fetchTenders();
        }
        emit(TenderLoaded(tenders: tenders));
      } catch (e) {
        emit(TenderError(message: e.toString()));
      }
    });
  }
}
