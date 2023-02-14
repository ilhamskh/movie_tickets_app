part of 'genre_bloc.dart';

abstract class GenreEvent extends Equatable {
  const GenreEvent();

  @override
  List<Object> get props => [];
}

class GenreEventStarted extends GenreEvent {
  const GenreEventStarted();

  @override 
  List<Object> get props => [];
}
