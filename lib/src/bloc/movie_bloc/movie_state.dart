part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();
  
  @override
  List<Object> get props => [];
}

class MovieInitial extends MovieState {

}

class MovieLoaded extends MovieState {
  final List<Movie> movieList;
  const MovieLoaded(this.movieList);

  @override 
  List<Object> get props => [movieList];
}

class MovieError extends MovieState {
  
}
