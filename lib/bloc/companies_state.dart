import 'package:equatable/equatable.dart';
import 'package:turkesh_marketer/model/compaines_model.dart';

abstract class CompaniesState extends Equatable {
  const CompaniesState();

  @override
  List<Object?> get props => [];
}

class CompaniesInitial extends CompaniesState {}

class CompaniesLoading extends CompaniesState {}

class CompaniesLoaded extends CompaniesState {
  final List<CompaniesModel> companies;

  const CompaniesLoaded(this.companies);

  @override
  List<Object?> get props => [companies];
}

class CompaniesError extends CompaniesState {
  final String message;

  const CompaniesError(this.message);

  @override
  List<Object?> get props => [message];
}
