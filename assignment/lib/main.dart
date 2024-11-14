import 'package:assignment/bloc/bloc/post_bloc.dart';
import 'package:assignment/model/post.dart';
import 'package:assignment/screen/post_list_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PostAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PostBloc()..add(FetchPostEvent()),
        ),
      ],
      child: const MaterialApp(
        title: 'Assignment',
        home: PostListDetails(),
      ),
    );
  }
}
