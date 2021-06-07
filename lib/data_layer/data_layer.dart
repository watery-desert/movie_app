import 'dart:async';
import 'json_data.dart';

class DataLayer {
  StreamController<List<Map<String, dynamic>>> moviesData = StreamController();

  DataLayer() {
    moviesData.add(rawData);
  }

  Stream<List<Map<String, dynamic>>> getData() => moviesData.stream;
}
