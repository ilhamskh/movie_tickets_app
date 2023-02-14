part of 'genre_bloc.dart';

abstract class GenreState extends Equatable {
  const GenreState();
  
  @override
  List<Object> get props => [];
}

class GenreInitial extends GenreState {

}

class GenreLoaded extends GenreState {
  final List<Genre> genreList;
  const GenreLoaded(this.genreList);

  @override 
  List<Object> get props => [genreList];
}

class GenreError extends GenreState {
  
}