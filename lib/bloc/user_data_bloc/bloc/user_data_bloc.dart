import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkesh_marketer/bloc/user_data_bloc/bloc/user_data_event.dart';
import 'package:turkesh_marketer/bloc/user_data_bloc/bloc/user_data_state.dart';
import 'package:turkesh_marketer/repository/get_user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc(this.userRepository) : super(UserInitial()) {
    on<FetchUserData>((event, emit) async {
      emit(UserLoading());
      try {
        final user = await userRepository.getUserData();
        if (user != null) {
          emit(UserLoaded(user));
        } else {
          emit(UserError("Failed to load user data"));
        }
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }
}
