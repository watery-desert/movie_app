import 'package:flutter/material.dart';
import '../../widget/staggered_pages/staggered_pages.dart';
import '../../../models/movie.dart';

import 'movie_details.dart';

class MoviesCard extends StatelessWidget {
  final bool showCards;
  final PageController pageController;
  final OnPageChangeCallback onPageChangeCallback;

  final List<Movie> moovisList;

  MoviesCard({
    required this.showCards,
    required this.pageController,
    required this.moovisList,
    required this.onPageChangeCallback,
  });





  @override
  Widget build(BuildContext context) {
    // final moovisList = widget.moovisList.reversed.toList();
    // final pageController = widget.pageController;
    // final onPageChangeCallback = widget.onPageChangeCallback;
    // final showCards = widget.showCards;
    return showCards
        ? StaggerPages(
            onPageChangeCallback: onPageChangeCallback,
            pageController: pageController,
            child: (index, _) => MooviDetails(moovisList[index]),
            pageCount: moovisList.length)
        : SizedBox();
  }
}
