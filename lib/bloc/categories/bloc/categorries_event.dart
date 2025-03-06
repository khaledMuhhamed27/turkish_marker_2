import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class LoadCategoriesEvent extends CategoryEvent {}

class FetchSubcategories extends CategoryEvent {
  final int parentId;

  const FetchSubcategories(this.parentId);

  @override
  List<Object> get props => [parentId];
}
