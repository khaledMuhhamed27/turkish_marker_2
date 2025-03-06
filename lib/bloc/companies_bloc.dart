import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkesh_marketer/bloc/companies_event.dart';
import 'package:turkesh_marketer/bloc/companies_state.dart';
import 'package:turkesh_marketer/repository/all_companies_repo.dart';

class CompaniesBloc extends Bloc<CompaniesEvent, CompaniesState> {
  final CompaniesRepository repository;

  CompaniesBloc(this.repository) : super(CompaniesInitial()) {
    on<FetchCompanies>(_onFetchCompanies);
  }

  Future<void> _onFetchCompanies(
      FetchCompanies event, Emitter<CompaniesState> emit) async {
    emit(CompaniesLoading());
    try {
      final companies = await repository.fetchCompanies();
      emit(CompaniesLoaded(companies));
    } catch (e) {
      emit(CompaniesError("حدث خطأ أثناء جلب البيانات: $e"));
    }
  }
}
