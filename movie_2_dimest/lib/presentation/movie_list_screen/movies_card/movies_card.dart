import 'package:flutter/material.dart';
import '../../widget/staggered_pages/staggered_pages.dart';
import '../../../models/movie.dart';

import 'movie_details.dart';

class MoviesCard extends StatelessWidget {
  final bool showCards;
  final PageController pageController;
  final OnPageChangeCallback onPageChangeCallback;
  final VoidCallback onTapCard;

  final List<Movie> moovisList;

  MoviesCard({
    required this.showCards,
    required this.pageController,
    required this.moovisList,
    required this.onPageChangeCallback,
    required this.onTapCard,
  });

  @override
  Widget build(BuildContext context) {

    return showCards
        ? StaggerPages(
            onPageChangeCallback: onPageChangeCallback,
            pageController: pageController,
            child: (index, _) => MooviDetails(
                  moovisList[index],
                  onTapCard,
                ),
            pageCount: moovisList.length)
        : SizedBox();
  }
}
