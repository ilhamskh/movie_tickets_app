import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_tickets_app/src/bloc/movie_bloc/movie_bloc.dart';
import 'package:movie_tickets_app/src/bloc/movie_bloc/movie_bloc.dart';
import 'package:movie_tickets_app/src/models/style.dart';
import 'package:movie_tickets_app/src/ui/screens/BottomNavbar.dart';
import 'package:movie_tickets_app/src/ui/screens/HomeScreen.dart';

void main() {
  runApp(
    BlocProvider<MovieBloc>(
      create: (context) {
        return MovieBloc()..add(MovieEventStarted());
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
            displayLarge: TextStyle(
              color: Colors.white,
              fontFamily: 'SanFrancisco',
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
            displayMedium: TextStyle(
              color: Colors.white,
              fontFamily: 'SanFrancisco',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            displaySmall: TextStyle(
              color: Styles.textColor,
              fontFamily: 'SanFrancisco',
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            titleSmall:TextStyle(
              color: Colors.white,
              fontFamily: 'SanFrancisco',
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ), 
            titleLarge: TextStyle(
              color: Colors.white,
              fontFamily: 'SanFrancisco',
              fontWeight: FontWeight.w100,
              fontSize: 26,
            ), 
          ),
        ),
        home: const BottomNavbar(),
      ),
    ),
  );
}
