import 'package:flutter/material.dart';
import '../../../models/movie.dart';
import '../../../models/actor.dart';

TextStyle titleStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

Widget buildActorTile(Actor actor) {
  return Column(
    children: [
      Container(
        margin: const EdgeInsets.all(8.0),
        width: 100,
        height: 100,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(actor.avatarURL),
        ),
      ),
      Text(actor.name),
    ],
  );
}

class BuildBottom extends StatelessWidget {
  final Movie movie;
  BuildBottom(this.movie);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 88.0),
      height: 350,
      // color: Colors.amber,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Actors',
                style: titleStyle,
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: movie.actors
                    .map(
                      (actor) => buildActorTile(actor),
                    )
                    .toList(),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                'Introduction',
                style: titleStyle,
              ),
            ),
            Text(
              movie.introduction,
              style: TextStyle(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
