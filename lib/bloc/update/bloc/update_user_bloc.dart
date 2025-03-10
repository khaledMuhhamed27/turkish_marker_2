import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkesh_marketer/bloc/update/bloc/update_user_event.dart';
import 'package:turkesh_marketer/bloc/update/bloc/update_user_state.dart';
import 'package:turkesh_marketer/repository/update_user_repo.dart';

class UpdateUserBloc extends Bloc<UpdateUserEvent, UpdateUserState> {
  final UpdateUserRepository userRepository;

  UpdateUserBloc({required this.userRepository}) : super(UpdateUserInitial()) {
    on<UpdateUserEvent>((event, emit) async {
      emit(UpdateUserLoading());
      try {
        final updatedUser = await userRepository.updateUserProfile(
          event.name,
          event.email,
          event.mobile,
          event.token,
        );
        emit(UserUpdated(updatedUser: updatedUser));
      } catch (e) {
        emit(UpdateUserError(message: e.toString()));
      }
    });
  }
}
