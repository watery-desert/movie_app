import 'package:flutter/material.dart';

import 'presentation/movie_list_screen/movie_list_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MovieListScreen(),
    );
  }
}
