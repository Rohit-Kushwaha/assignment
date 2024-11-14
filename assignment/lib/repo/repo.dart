import 'dart:convert';

import 'package:assignment/local_storage/hive_boxes.dart';
import 'package:assignment/model/post.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class PostRepository {
  Future<List<Post>> fetchPost() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    if (response.statusCode == 200) {
      List josnList = jsonDecode(response.body);
      List<Post> posts = josnList.map((json) {
        return Post(id: json['id'], title: json['title'], body: json['body']);
      }).toList();

      return posts;
    } else {
      throw Exception("Failed to load posts");
    }
  }

  Future<void> updatePostReadStatus(int postId) async {
    final box = await Hive.openBox<Post>(HiveBoxes.postBox);

    final post = box.get(postId);

    if (post != null) {
      post.isRead = true;
      await box.put(postId, post);
    }
  }
}
