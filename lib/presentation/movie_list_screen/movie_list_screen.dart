import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:movie_2_dimest/data.dart';

import '../../models/movie.dart';
import 'movies_card/movies_card.dart';
import 'background_image_slide.dart';
import '../widget/button/movie_button.dart';

class MovieListScreen extends StatefulWidget {
  MovieListScreen();

  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  List<Movie> movies = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    movies = rawData
        .map(
          (data) => Movie(
              title: data["title"],
              index: data["index"],
              location: data["image"],
             ),
        )
        .toList();
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.8,
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final reversedMovieList = movies.reversed.toList();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: <Widget>[
            Stack(
              children: reversedMovieList.map((movie) {
                return BackgroundImageSlide(
                  pageController: _pageController,
                  deviceWidth: deviceWidth,
                  imageURL: movie.location,
                  backgroundIndex: movie.index,
                );
              }).toList(),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.3, 0.8]),
              ),
            ),
            MoviesCard(
              pageController: _pageController,
              movieList: movies,
              onPageChangeCallback: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
            Positioned(
              bottom: 32.0,
              left: 0.0,
              right: 0.0,
              child: MovieButton(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
