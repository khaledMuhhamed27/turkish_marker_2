import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkesh_marketer/bloc/categories/bloc/categorries_event.dart';
import 'package:turkesh_marketer/bloc/categories/bloc/categorries_state.dart';
import 'package:turkesh_marketer/repository/all_categories_repo.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository repository;

  CategoryBloc({required this.repository}) : super(CategoryInitial()) {
    on<LoadCategoriesEvent>(_onLoadCategories);
    on<FetchSubcategories>(_onFetchSubcategories);
  }

  Future<void> _onLoadCategories(
      LoadCategoriesEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());

    try {
      final response = await repository.getCategories();
      emit(CategoryLoaded(
        categories: response.categories,
        countCategories: response.countCategories,
        countSubCategories: response.countSubCategories,
      ));
    } catch (e) {
      emit(CategoryError(message: "حدث خطأ أثناء تحميل الفئات: $e"));
    }
  }

  Future<void> _onFetchSubcategories(
      FetchSubcategories event, Emitter<CategoryState> emit) async {
    try {
      final subcategories = await repository.getSubcategories(event.parentId);
      print("🟢 الفئات الفرعية المحملة: $subcategories");

      if (state is CategoryLoaded) {
        final currentState = state as CategoryLoaded;
        emit(CategoryLoaded(
          categories: currentState.categories, // حافظ على الفئات الرئيسية
          countCategories: currentState.countCategories,
          countSubCategories: currentState.countSubCategories,
        ));
      }

      emit(SubcategoriesLoaded(
          subcategories: subcategories)); // عرض الفئات الفرعية
    } catch (e) {
      emit(CategoryError(
        message: "Error:e",
      ));
    }
  }
}
