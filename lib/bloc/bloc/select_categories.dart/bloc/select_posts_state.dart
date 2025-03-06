import 'package:equatable/equatable.dart';
import 'package:turkesh_marketer/model/show_select_categ_model.dart';

sealed class SelectPostsState extends Equatable {
  const SelectPostsState();

  @override
  List<Object?> get props => [];
}

// initial
final class SelectPostsInitial extends SelectPostsState {}

// loading
final class LoadingPostsState extends SelectPostsState {}

// loaded
final class LoadedPostsState extends SelectPostsState {
  final List<Post> posts;
  const LoadedPostsState(this.posts);

  @override
  List<Object?> get props => [posts];
}

// error
final class ErrorPostsState extends SelectPostsState {
  final String message;
  const ErrorPostsState(this.message);
  @override
  List<Object?> get props => [message];
}
