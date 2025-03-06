import 'package:equatable/equatable.dart';
import 'package:turkesh_marketer/model/tender_model.dart';

abstract class TenderState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TenderLoading extends TenderState {}

class TenderLoaded extends TenderState {
  final List<Tender> tenders;

  TenderLoaded({required this.tenders});

  @override
  List<Object?> get props => [tenders];
}

class TenderError extends TenderState {
  final String message;

  TenderError({required this.message});

  @override
  List<Object?> get props => [message];
}
