import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkesh_marketer/bloc/bloc/cooperation_event.dart';
import 'package:turkesh_marketer/model/cooperations_model.dart';
import 'package:turkesh_marketer/repository/all_cooperations_repo.dart';

part 'cooperation_state.dart';

class CooperationBloc extends Bloc<CooperationEvent, CooperationState> {
  final CooperationRespository cooperationRespository;
  CooperationBloc(this.cooperationRespository) : super(CooperationInitial()) {
    // inter the event here
    on<FetchCooperationsByType>((event, emit) async {
      emit(CooperationLoading());
      try {
        final cooperations =
            await cooperationRespository.getCooperationsByType(event.type);
        emit(CooperationLoaded(cooperations));
      } catch (e) {
        emit(CooperationError("Failed to fetch data: $e"));
      }
    });
  }
}
