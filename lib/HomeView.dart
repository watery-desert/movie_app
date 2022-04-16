import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'movie.dart';
import 'movie_details.dart';

import 'background_image_slide.dart';
import 'movie_button.dart';
import 'staggered_pages.dart';

class HomeView extends StatefulWidget {
  HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
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
            StaggeredPages(
              onPageChangeCallback: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              pageController: _pageController,
              child: (index, _) => MovieDetails(
                movies[index],
              ),
              pageCount: movies.length,
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
}
