import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkesh_marketer/bloc/categories/bloc/categorries_event.dart';
import 'package:turkesh_marketer/bloc/categories/bloc/categorries_state.dart';

import 'package:turkesh_marketer/repository/all_categories_repo.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository repository;

  CategoryBloc({required this.repository}) : super(CategoryInitial()) {
    on<LoadCategoriesEvent>(_onLoadCategories);
  }

  Future<void> _onLoadCategories(
      LoadCategoriesEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());

    try {
      final response = await repository.getCategories();
      emit(CategoryLoaded(
        categories: response.categories,
        countCategories: response.countCategories,
      ));
    } catch (e) {
      emit(CategoryError(message: "حدث خطأ أثناء تحميل الفئات: $e"));
    }
  }
}
