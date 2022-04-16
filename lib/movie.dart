// import 'actor.dart';

class Movie {
  final String title;
  final String location;
  final int index;

  Movie({
    required this.title,
    required this.index,
    required this.location,
  });
}


List<Map<String, dynamic>> rawData = [
  {
    'title': 'Good Boys',
    'image': 'assets/images/good_boys.jpg',
    'index': 1,
  },
  {
    'title': 'Joker',
    'image': 'assets/images/joker.png',
    'index': 2,
  },
  {
    'title': 'The Irishman',
    'image': 'assets/images/the_irishman.jpg',
    'index': 3,
  },
  {
    'title': 'Lion King',
    'image': 'assets/images/Lion_King.jpg',
    'index': 4,
  },
];