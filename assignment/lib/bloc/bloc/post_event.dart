part of 'post_bloc.dart';

@immutable
sealed class PostEvent {}

class FetchPostEvent extends PostEvent {

}

class MarkAsReadEvent extends PostEvent {
  final int postId;
  MarkAsReadEvent(this.postId);
}
