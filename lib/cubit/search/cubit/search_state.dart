import 'package:equatable/equatable.dart';
import 'package:turkesh_marketer/model/search_model.dart';

// الحالة الأساسية للـ SearchState
abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

// حالة بداية البحث (عند البدء أو عند مسح النص)
class SearchInitial extends SearchState {}

// حالة التحميل (عند بدء البحث أو تحميل البيانات)
class SearchLoading extends SearchState {}

// حالة النجاح (عند جلب البيانات بنجاح من الـ API)
class SearchSuccess extends SearchState {
  final SearchResult result;

  const SearchSuccess(this.result);

  @override
  List<Object?> get props => [result];
}

// حالة الفشل (عند حدوث خطأ أثناء جلب البيانات)
class SearchFailure extends SearchState {
  final String error;

  const SearchFailure(this.error);

  @override
  List<Object?> get props => [error];
}
