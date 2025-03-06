part of 'local_cubit.dart';

@immutable
sealed class LocalState {}

final class LocalInitial extends LocalState {}

final class ChangeLocalState extends LocalState {
  final Locale local;

  ChangeLocalState({required this.local});
}
