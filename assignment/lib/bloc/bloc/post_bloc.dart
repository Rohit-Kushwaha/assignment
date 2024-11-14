import 'package:assignment/model/post.dart';
import 'package:assignment/repo/repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository = PostRepository();
  PostBloc() : super(PostInitial()) {
    on<PostEvent>((event, emit) async {
      emit(PostLoading());
      try {
        // fetch the post
        final posts = await postRepository.fetchPost();
        emit(PostLoaded(posts));
      } catch (e) {
        emit(PostError("Failed to load post"));
      }
    });

    on<MarkAsReadEvent>((event,emit) async {
      final currentState = state;
      if(currentState is PostLoaded){
        final posts = currentState.post.map((post){
          if(post.id == event.postId) post.isRead = true;
          return post;
        }).toList();
        await postRepository.updatePostReadStatus(event.postId); // make method
        emit(PostLoaded(posts));
      }
    });


  }
}
