part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadUserEvent extends UserEvent {
  final String email;
  final String token;

  const LoadUserEvent({required this.email, required this.token});
  @override
  List<Object> get props => [email, token];
}
