import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_2_dimest/repository/movie_repo.dart';

import 'bloc/movie_bloc.dart';
import 'presentation/movie_list_screen/movie_list_screen.dart';

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Builder(builder: (context) {
        return BlocProvider<MovieBloc>(
          create: (context) => MovieBloc(
            movieRepo: MovieRepo(),
          )..add(LoadMovies()),
          child: MovieListScreen(),
        );
      }),
    );
  }
}


