import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../repository/movie_repo.dart';
part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepo _movieRepo;
  StreamSubscription? _movieSub;
  MovieBloc({required MovieRepo movieRepo})
      : _movieRepo = movieRepo,
        super(MovieLoading());

  @override
  Stream<MovieState> mapEventToState(
    MovieEvent event,
  ) async* {
    if (event is LoadMovies) {
      yield* _mapLoadMoviesToState();
    } else if (event is MoviesUpated) {
      yield* _mapMoviesUpatedToState(event);
    }
  }

  Stream<MovieState> _mapLoadMoviesToState() async* {
    _movieSub?.cancel();
    _movieRepo.getMovies().listen((event) {
      add(MoviesUpated(event));
    });
  }

  Stream<MovieState> _mapMoviesUpatedToState(MoviesUpated event) async* {
    await Future.delayed(Duration(seconds: 2));
    yield MovieLoaded(event.movies);
  }

  @override
  Future<void> close() {
    _movieSub?.cancel();
    return super.close();
  }
}
