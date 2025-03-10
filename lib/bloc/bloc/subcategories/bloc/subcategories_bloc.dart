import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkesh_marketer/bloc/bloc/subcategories/bloc/subcategories_event.dart';
import 'package:turkesh_marketer/bloc/bloc/subcategories/bloc/subcategories_state.dart';

import 'package:turkesh_marketer/repository/all_categories_repo.dart';

class SubcategoryBloc extends Bloc<SubcategoriesEvent, SubcategoriesState> {
  final CategoryRepository repository;

  SubcategoryBloc({required this.repository}) : super(SubcategoriesInitial()) {
    on<FetchSubcategories>(_onFetchSubcategories);
  }

  Future<void> _onFetchSubcategories(
      FetchSubcategories event, Emitter<SubcategoriesState> emit) async {
    emit(SubcategoriesLoading());

    try {
      final subcategories = await repository.getSubcategories(event.parentId);
      emit(SubcategoriesLoaded(subcategories: subcategories));
    } catch (e) {
      emit(SubcategoriesError(
          message: "حدث خطأ أثناء تحميل الفئات الفرعية: $e"));
    }
  }
}
