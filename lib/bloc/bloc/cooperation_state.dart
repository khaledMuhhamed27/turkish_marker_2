part of 'cooperation_bloc.dart';

sealed class CooperationState extends Equatable {
  const CooperationState();

  @override
  List<Object> get props => [];
}

// initial
final class CooperationInitial extends CooperationState {}

// loading
final class CooperationLoading extends CooperationState {}

// loaded
final class CooperationLoaded extends CooperationState {
  final List<CooperationsModel> cooperationModel;

  const CooperationLoaded(this.cooperationModel);

  @override
  List<Object> get props => [cooperationModel];
}

// error
final class CooperationError extends CooperationState {
  final String message;
  const CooperationError(this.message);
  @override
  List<Object> get props => [message];
}
