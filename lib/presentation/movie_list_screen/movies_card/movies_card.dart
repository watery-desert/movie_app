import 'package:flutter/material.dart';
import '../../widget/staggered_pages/staggered_pages.dart';
import '../../../models/movie.dart';

import 'movie_details.dart';

class MoviesCard extends StatelessWidget {
  final PageController pageController;
  final OnPageChangeCallback onPageChangeCallback;

  final List<Movie> movieList;

  MoviesCard({
    required this.pageController,
    required this.movieList,
    required this.onPageChangeCallback,
  });

  @override
  Widget build(BuildContext context) {
    return StaggeredPages(
        onPageChangeCallback: onPageChangeCallback,
        pageController: pageController,
        child: (index, _) => MovieDetails(
              movieList[index],
            ),
        pageCount: movieList.length);
  }
}
