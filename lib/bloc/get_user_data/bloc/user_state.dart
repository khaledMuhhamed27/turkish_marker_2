part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

// initial
final class UserInitial extends UserState {}

// loading
final class UserLoading extends UserState {}

// loaded
final class UserLoaded extends UserState {
  final UserModel user;

  const UserLoaded({required this.user});

  @override
  List<Object?> get props => [user];
}

// error
final class UserError extends UserState {
  final String message;

  const UserError({required this.message});
  @override
  List<Object> get props => [message];
}
