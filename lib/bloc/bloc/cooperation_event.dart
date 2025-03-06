import 'package:equatable/equatable.dart';

abstract class CooperationEvent extends Equatable {
  const CooperationEvent();

  @override
  List<Object> get props => [];
}

class FetchCooperationsByType extends CooperationEvent {
  final String type;

  const FetchCooperationsByType(this.type);

  @override
  List<Object> get props => [type];
}
