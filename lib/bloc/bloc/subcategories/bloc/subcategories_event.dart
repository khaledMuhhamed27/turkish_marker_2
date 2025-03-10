import 'package:equatable/equatable.dart';

sealed class SubcategoriesEvent extends Equatable {
  const SubcategoriesEvent();

  @override
  List<Object> get props => [];
}

class FetchSubcategories extends SubcategoriesEvent {
  final int parentId;

  const FetchSubcategories(this.parentId);

  @override
  List<Object> get props => [parentId];
}
