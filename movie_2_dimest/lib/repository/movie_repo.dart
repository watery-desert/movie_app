import '../models/movie.dart';
import '../data_layer/data_layer.dart';
export '../models/movie.dart';

class MovieRepo {
  DataLayer _dataLayer = DataLayer();

  Stream<List<Movie>> getMovies() {
    final result = _dataLayer.getData().map(
          (event) => event.map((rawMap) => Movie.fromMap(rawMap)).toList(),
        );
    return result;
  }
}
