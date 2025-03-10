// states/category_state.dart
import 'package:equatable/equatable.dart';
import 'package:turkesh_marketer/model/categories_modell.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<Category> categories;
  final int countCategories;

  const CategoryLoaded({
    required this.categories,
    required this.countCategories,
  });

  @override
  List<Object> get props => [categories, countCategories];
}

class CategoryError extends CategoryState {
  final String message;

  const CategoryError({required this.message});

  @override
  List<Object> get props => [message];
}
