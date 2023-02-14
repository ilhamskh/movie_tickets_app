import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_tickets_app/src/services/movieApiService.dart';

import '../../models/genre.dart';

part 'genre_event.dart';
part 'genre_state.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  GenreBloc() : super(GenreInitial()) {
    on<GenreEventStarted>((event, emit) async{
      MovieServices _service = MovieServices();
      List<Genre> genres = await _service.getGenres();
      emit(GenreLoaded(genres));
    });
  }
}
