import 'package:equatable/equatable.dart';
import 'package:turkesh_marketer/model/categories_modell.dart';

sealed class SubcategoriesState extends Equatable {
  const SubcategoriesState();

  @override
  List<Object> get props => [];
}

final class SubcategoriesInitial extends SubcategoriesState {}

// loading
final class SubcategoriesLoading extends SubcategoriesState {}
// loaded

class SubcategoriesLoaded extends SubcategoriesState {
  final List<Category> subcategories;

  const SubcategoriesLoaded({
    required this.subcategories,
  });

  @override
  List<Object> get props => [
        subcategories,
      ];
}
// error

final class SubcategoriesError extends SubcategoriesState {
  final String message;

  const SubcategoriesError({required this.message});
  @override
  List<Object> get props => [message];
}
