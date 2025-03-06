import 'package:equatable/equatable.dart';
import 'package:turkesh_marketer/model/import_model.dart';

abstract class ImportState extends Equatable {
  const ImportState();

  @override
  List<Object> get props => [];
}

class ImportInitial extends ImportState {}

class ImportLoading extends ImportState {}

class ImportLoaded extends ImportState {
  final List<ImportModel> imports;

  const ImportLoaded(this.imports);

  @override
  List<Object> get props => [imports];
}

class ImportError extends ImportState {
  final String message;

  const ImportError(this.message);

  @override
  List<Object> get props => [message];
}
