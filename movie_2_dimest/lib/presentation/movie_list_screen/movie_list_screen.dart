import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'movies_card/movies_card.dart';
import '../../data/data_source.dart';
import '../../models/movie.dart';
import 'background_image_slide.dart';
import 'movie_info_view/top_image_view.dart';
import 'movie_info_view/more_info_card.dart';
import '../widget/app_bar/transparent_appbar.dart';
import '../widget/button/movie_button.dart';
import '../seat_booking_screen/seat_booking_screen.dart';

class MovieListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Builder(builder: (context) {
        final deviceWidth = MediaQuery.of(context).size.width;
        return MyHomePage(deviceWidth: deviceWidth);
      }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required this.deviceWidth});

  final double deviceWidth;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  bool compactView = true;
  List<Movie> moviesList = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    moviesList = rawData.reversed
        .map(
          (data) => Movie.fromMap(
            data,
          ),
        )
        .toList();

    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final reversedMovieList = moviesList.reversed.toList();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          // alignment: Alignment.bottomCenter,
          children: <Widget>[
            if (compactView)
              Stack(
                children: moviesList.map((movie) {
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
            TopImageView(
              showCompactImageView: !compactView,
              leftImageURL: currentIndex == 0 ? null : reversedMovieList[currentIndex - 1].location,
              middleImageURL: reversedMovieList[currentIndex].location,
              rightImageURL: reversedMovieList[currentIndex + 1].location,
            ),
            MoreInfoCard(
              showMoreInfo: !compactView,
              movie: moviesList.reversed.toList()[currentIndex],
            ),
            MoviesCard(
              showCards: compactView,
              pageController: _pageController,
              moviesList: reversedMovieList,
              onTapCard: () {
                setState(() {
                  compactView = false;
                });
              },
              onPageChangeCallback: (index) {
                setState(() {
                  if (index < 3){
                    currentIndex = index;
                  }
                });
              },
            ),
            TransparentAppBar(),
            Positioned(
              bottom: 32.0,
              left: 0.0,
              right: 0.0,
              child: OpenContainer(
                transitionDuration: Duration(milliseconds: 800),
                closedColor: Colors.transparent,
                closedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                closedElevation: 0.0,
                tappable: true,
                closedBuilder: (context, action) {
                  return MovieButton(
                    title: 'BUY TICKET',
                    color: Colors.black87,
                    padding: compactView
                        ? const EdgeInsets.symmetric(horizontal: 62.0)
                        : EdgeInsets.symmetric(horizontal: 16),
                  );
                },
                openShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
                openColor: Colors.transparent,
                openElevation: 0.0,
                openBuilder: (context, action) => SeatBookingScreen(
                  reversedMovieList[currentIndex],
                ),
              ),
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
