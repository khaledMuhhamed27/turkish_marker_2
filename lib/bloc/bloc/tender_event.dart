import 'package:equatable/equatable.dart';

abstract class TenderEvent extends Equatable {
  const TenderEvent();

  @override
  List<Object> get props => [];
}

class LoadTendersEvent extends TenderEvent {
  final String? tenderSubtype;

  const LoadTendersEvent({this.tenderSubtype});

  @override
  List<Object> get props => [tenderSubtype ?? ''];
}
