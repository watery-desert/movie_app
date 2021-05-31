import 'actor.dart';

class Movie {
  final String title;
  final String location;
  final int index;
  final List<String> tags;
  final double ratings;
  final String director;
  final List<Actor> actors;
  final String introduction;
  final String trailerURL;

  Movie({
    required this.title,
    required this.index,
    required this.location,
    required this.tags,
    required this.ratings,
    required this.director,
    required this.actors,
    required this.introduction,
    required this.trailerURL,
  });

  factory Movie.fromMap(
    Map<String, dynamic> data,
  ) {
    final List<Actor> actorFromMap =
        (data['actors'] as List<Map<String, dynamic>>)
            .map((actor) => Actor.fromMap(actor))
            .toList();

    return Movie(
      title: data['title'],
      location: data['image'],
      index: data['index'],
      tags: data['tags'],
      ratings: data['ratings'],
      director: data['director'],
      actors: actorFromMap,
      introduction: data['introduction'],
      trailerURL: data['trailer'],
    );
  }
}
