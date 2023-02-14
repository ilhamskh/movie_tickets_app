import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/genre.dart';
import '../models/movie.dart';

class MovieServices {
  static const String baseUrl = "https://api.themoviedb.org/3/movie/";
  static const String apiKey = "api_key=6c4e7a30a67b4024305984b4b59c339a";

  Future<List<Movie>> getNowPlayingMovies() async {
    final response = await http.get(Uri.parse("${baseUrl}now_playing?$apiKey"));
    if (response.statusCode == 200) {
      print('Api succesfull');
      final data = jsonDecode(response.body)["results"];
      final movies = List<Movie>.from(data.map((item) => Movie.fromJson(item)));
      return movies;
    } else {
      throw Exception("Failed to load movies ${response.statusCode}");
    }
  }

  Future<List<Genre>> getGenres() async {
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3/genre/movie/list?$apiKey'));
    try {
      final data = json.decode(response.body)['genres'];
      final genres = List<Genre>.from(data.map((genre) => Genre.fromJson(genre)));
      return genres;
    }
    catch(error)
    {
      throw Exception('Something went wrong: $error');
    }
  }
}