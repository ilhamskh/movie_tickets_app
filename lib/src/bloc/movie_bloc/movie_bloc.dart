import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_tickets_app/src/models/movie.dart';
import 'package:movie_tickets_app/src/services/movieApiService.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieInitial()) {
    on<MovieEventStarted>((event, emit) async{
      MovieServices service = MovieServices();
      List<Movie> movieList = await service.getNowPlayingMovies();
      emit(MovieLoaded(movieList));
    });
  }
}
