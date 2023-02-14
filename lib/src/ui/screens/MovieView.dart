import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:movie_tickets_app/src/bloc/genre_bloc/genre_bloc.dart';
import 'package:movie_tickets_app/src/models/style.dart';

import '../../models/genre.dart';
import '../../models/movie.dart';

class MovieView extends StatefulWidget {
  final Movie movie;
  const MovieView({super.key, required this.movie});

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  bool _isFavorite = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Detail Movie',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        centerTitle: true,
        leading: Container(
          margin: const EdgeInsets.only(left: 15),
          child: InkWell(
            onTap: (() {
              Navigator.of(context).pop();
            }),
            child: Icon(FluentIcons.arrow_left_12_filled),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                });
              },
              child: Icon(_isFavorite
                  ? FluentIcons.bookmark_16_regular
                  : FluentIcons.bookmark_16_filled),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 30,
          ),
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 18,
                child: FadeInUp(
                  from: 80,
                  delay: const Duration(milliseconds: 200),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.45,
                    width: MediaQuery.of(context).size.width * 0.55,
                    decoration: BoxDecoration(
                        color: Styles.textColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                child: FadeInUp(
                  from: 70,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.45,
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: BoxDecoration(
                        color: Styles.textColor,
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.45,
                width: MediaQuery.of(context).size.width * 0.65,
                child: Hero(
                  tag: widget.movie.id,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://image.tmdb.org/t/p/w500/${widget.movie.posterPath}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    child: Text(
                      widget.movie.originalTitle,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      FadeInUp(
                        duration: const Duration(milliseconds: 500),
                        delay: const Duration(milliseconds: 200),
                        child: Text(
                          widget.movie.adult ? '+18 |  ' : '+13  |  ',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontSize: 16),
                        ),
                      ),
                      FadeInUp(
                        duration: const Duration(milliseconds: 500),
                        delay: const Duration(milliseconds: 200),
                        child: RatingStars(
                          value: widget.movie.voteAverage / 2,
                          maxValue: 5,
                          starCount: 5,
                          starSize: 15,
                          valueLabelColor: Styles.primaryColor,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  BlocProvider<GenreBloc>(
                    create: (context) => GenreBloc()..add(GenreEventStarted()),
                    child: BlocBuilder<GenreBloc, GenreState>(
                      builder: (context, state) {
                        if (state is GenreLoaded) {
                          List<Genre> genres = state.genreList
                              .where((element) =>
                                  widget.movie.genreIds.contains(element.id))
                              .toList();
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: genres
                                  .map(
                                    (genre) => FadeInRight(
                                      duration: const Duration(milliseconds: 500),
                                      delay: Duration(
                                          milliseconds:
                                              (genres.indexOf(genre) + 1) * 100),
                                      from: 60,
                                      child: Container(
                                        margin: const EdgeInsets.only(right: 10),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 10),
                                        decoration: BoxDecoration(
                                            color: Styles.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: Text(
                                          genre.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.copyWith(
                                                fontSize: 12,
                                                color:
                                                    Colors.white.withOpacity(0.8),
                                              ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 400),
                    child: Text(
                      'Overview',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 500),
                    child: Text(
                      widget.movie.overview,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Styles.textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
