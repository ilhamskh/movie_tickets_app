import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_tickets_app/src/bloc/genre_bloc/genre_bloc.dart';
import 'package:movie_tickets_app/src/models/style.dart';
import 'package:movie_tickets_app/src/ui/widgets/CategoryItem.dart';
import 'package:movie_tickets_app/src/ui/widgets/DoubleText.dart';
import 'package:movie_tickets_app/src/ui/widgets/MovieCard.dart';
import '../../bloc/movie_bloc/movie_bloc.dart';
import '../../models/genre.dart';
import '../../models/movie.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'DiscoverScreen.dart';
import 'ProfileScreen.dart';
import 'WatchListScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styles.bgColor,
        body: GestureDetector(
          onTap: (() => FocusScope.of(context).unfocus()),
          child: ListView(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Hi, İlham!',
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          Container(
                            height: 45,
                            width: 45,
                            child: CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    AssetImage('assets/avatar.png')),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Styles.textColor),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Styles.textColor),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          hintText: 'Search your movie',
                          hintStyle: TextStyle(color: Styles.textColor),
                          prefixIcon: Icon(
                            FluentIcons.search_48_regular,
                            color: Styles.textColor,
                          ),
                        ),
                        style: TextStyle(color: Styles.textColor),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    BlocProvider<GenreBloc>(
                      create: ((context) {
                        return GenreBloc()..add(GenreEventStarted());
                      }),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(children: [
                          DoubleTextWidget(
                              biggerText: "Categories",
                              smallerText: 'See more'),
                          const SizedBox(
                            height: 20,
                          ),
                          BlocBuilder<GenreBloc, GenreState>(
                            builder: (context, state) {
                              if (state is GenreInitial) {
                                return CircularProgressIndicator();
                              } else if (state is GenreLoaded) {
                                List<Genre> genres = state.genreList;
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CategoryItem(
                                      title: genres.firstWhere((element) => element.id == 27).name,
                                      emoji: "😱",
                                    ),
                                    CategoryItem(
                                      title: genres.firstWhere((element) => element.id == 10749).name,
                                      emoji: "🥰",
                                    ),
                                    CategoryItem(
                                      title: genres.firstWhere((element) => element.id == 35).name,
                                      emoji: "🤣",
                                    ),
                                    CategoryItem(
                                      title: genres.firstWhere((element) => element.id == 18).name,
                                      emoji: "🙁",
                                    )
                                  ],
                                );
                              } else {
                                return Text('Something went wrong');
                              }
                            },
                          )
                        ]),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: DoubleTextWidget(
                              biggerText: "Now Playing",
                              smallerText: 'See more'),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        BlocBuilder<MovieBloc, MovieState>(
                          builder: ((context, state) {
                            if (state is MovieLoaded) {
                              List<Movie> movies = state.movieList;
                              return CarouselSlider.builder(
                                itemCount: movies.length,
                                itemBuilder: ((context, index, realIndex) {
                                  Movie movie = movies[index];
                                  return MovieCard(
                                    movie: movie,
                                  );
                                }),
                                options: CarouselOptions(
                                  autoPlay: true,
                                  height: 400,
                                  aspectRatio: 1 / 1,
                                  viewportFraction: 0.6,
                                  enlargeCenterPage: false,
                                ),
                              );
                            } else if (state is MovieInitial) {
                              return CircularProgressIndicator(
                                color: Colors.white,
                              );
                            } else {
                              return Text('Something went wrong');
                            }
                          }),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
