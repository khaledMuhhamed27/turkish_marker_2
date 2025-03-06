import 'package:equatable/equatable.dart';

sealed class SelectPostsEvent extends Equatable {
  const SelectPostsEvent();

  @override
  List<Object?> get props => [];
}

class LoadPostsEvent extends SelectPostsEvent {
  final String parentId;

  const LoadPostsEvent({required this.parentId});

  @override
  List<Object> get props => [parentId];
}
