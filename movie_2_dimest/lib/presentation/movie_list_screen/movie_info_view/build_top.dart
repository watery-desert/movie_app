import 'package:flutter/material.dart';
import '../../../models/movie.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constant/constant.dart';

class BuildTop extends StatelessWidget {
  final Movie moovi;

  BuildTop(this.moovi);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          moovi.title,
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
          children: moovi.tags
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
          initialRating: moovi.ratings,
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
        SizedBox(
          height: 8.0,
        ),
        Text('Director: ${moovi.director}'),
      ],
    );
  }
}
