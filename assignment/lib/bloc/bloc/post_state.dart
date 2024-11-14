part of 'post_bloc.dart';

@immutable
sealed class PostState extends Equatable {
  @override
  List<Object> get props => [];
}

final class PostInitial extends PostState {}

final class PostLoading extends PostState {}

final class PostLoaded extends PostState {
  final List<Post> post;
  PostLoaded(this.post);

  @override
  List<Object> get props => [post];
}

final class PostError extends PostState {
  final String error;
  PostError(this.error);

  @override
  List<Object> get props => [error];
}
