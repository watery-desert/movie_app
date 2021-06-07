part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class LoadMovies extends MovieEvent {}

class MoviesUpated extends MovieEvent {
  final List<Movie> movies;

  MoviesUpated(this.movies);

  @override
  List<Object> get props => [movies];
}
