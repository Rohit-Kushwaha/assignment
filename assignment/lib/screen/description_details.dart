import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DescriptionDetails extends StatelessWidget {
  const DescriptionDetails({super.key, required this.id});

  final int id;

  Future<String> fetchPostDetails() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'));
    if (response.statusCode == 200) {
      // debugPrint(response.body.toString());

      return jsonDecode(response.body)['body'];
    } else {
      throw Exception("Failed to load post details");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Description"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: fetchPostDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(
                  16.0,
                ),
                child: Text(snapshot.data ?? ''),
              );
            }
          }),
    );
  }
}
