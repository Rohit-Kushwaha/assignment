import 'package:assignment/bloc/bloc/post_bloc.dart';
import 'package:assignment/screen/description_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class PostListDetails extends StatefulWidget {
  const PostListDetails({super.key});

  @override
  State<PostListDetails> createState() => _PostListDetailsState();
}

class _PostListDetailsState extends State<PostListDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post List"),
        centerTitle: true,
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PostError) {
            return Center(
              child: Text("Error :  ${state.error}"),
            );
          } else if (state is PostLoaded) {
            final posts = state.post;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return GestureDetector(
                    onTap: () {
                      context.read<PostBloc>().add(MarkAsReadEvent(post.id));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DescriptionDetails(id: post.id)));
                    },
                    child: Container(
                      color: post.isRead ? Colors.white : Colors.yellow,
                      child: Row(
                        children: [
                          Expanded(child: Text(post.title)),
                          const Icon(
                            Icons.timer,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
              ),
            );
          } else {
            return Container(
              child: const Text("No post available"),
            );
          }
        },
      ),
    );
  }
}
