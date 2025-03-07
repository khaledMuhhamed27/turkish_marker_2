import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkesh_marketer/cubit/search/cubit/search_state.dart';
import 'package:turkesh_marketer/repository/search_repo.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepository _searchRepository;

  SearchCubit(this._searchRepository) : super(SearchInitial());

  // دالة البحث التي ستبدأ عند تغيير النص
  Future<void> search(String query) async {
    if (query.isEmpty) {
      emit(
          SearchInitial()); // إذا كان النص فارغًا، العودة إلى الحالة الابتدائية
      return;
    }

    try {
      emit(SearchLoading()); // إطلاق حالة التحميل
      final result = await _searchRepository.search(query);
      emit(SearchSuccess(result)); // إطلاق حالة النجاح مع البيانات
    } catch (e) {
      emit(SearchFailure(e.toString())); // إطلاق حالة الفشل مع رسالة الخطأ
    }
  }
}
