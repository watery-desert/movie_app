import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'movie.dart';


class MovieDetails extends StatelessWidget {
  final Movie movie;
  MovieDetails(
    this.movie,
  );
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
          Container(
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
          Text(
            movie.title,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (index) => Icon(
                FontAwesomeIcons.solidStar,
                size: 18,
                color: Colors.orange,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
