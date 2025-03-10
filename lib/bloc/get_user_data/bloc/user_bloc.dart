import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:turkesh_marketer/model/get_user_data.dart';
import 'package:turkesh_marketer/repository/get_user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<LoadUserEvent>((event, emit) async {
      emit(UserLoading());
      try {
        final user = await userRepository.getUser(event.email, event.token);
        emit(UserLoaded(user: user));
      } catch (e) {
        emit(UserError(message: e.toString()));
      }
    });
  }
}
