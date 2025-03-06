import 'package:equatable/equatable.dart';

abstract class ImportEvent extends Equatable {
  const ImportEvent();

  @override
  List<Object> get props => [];
}

class FetchImportsByType extends ImportEvent {
  final String type;

  const FetchImportsByType(this.type);

  @override
  List<Object> get props => [type];
}
