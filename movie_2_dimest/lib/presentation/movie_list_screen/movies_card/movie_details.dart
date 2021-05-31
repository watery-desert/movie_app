import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../models/movie.dart';
import '../../../constant/constant.dart';

class MovieDetails extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;
  MovieDetails(this.movie, this.onTap,);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(8.0, 250, 8.0, 0.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(
                0.08,
              ),
              blurRadius: 4.0),
        ],
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(32),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.fromLTRB(32.0, 32.0, 32.0, 8.0),
              width: double.infinity,
              height: 340,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
                child: Image.asset(
                  movie.location,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Text(
            movie.title,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8.0,
            children: movie.tags
                .map(
                  (tag) => Chip(
                    labelPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    shape: StadiumBorder(
                      side: BorderSide(width: 0.5, color: chipColor),
                    ),
                    backgroundColor: Colors.transparent,
                    label: Text(
                      tag,
                      style: TextStyle(
                        fontSize: 12,
                        color: chipColor,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          SizedBox(
            height: 8.0,
          ),
          RatingBar.builder(
            ignoreGestures: true,
            itemSize: 18,
            initialRating: movie.ratings,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.orange,
              ),
            ),
            onRatingUpdate: (_) {},
          ),
        ],
      ),
    );
  }
}
