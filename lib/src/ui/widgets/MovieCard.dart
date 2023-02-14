import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:movie_tickets_app/src/models/style.dart';
import 'package:movie_tickets_app/src/ui/screens/MovieView.dart';

import '../../models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard(
      {super.key, required this.movie,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
          return MovieView(movie: movie,);
        })));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: movie.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: CachedNetworkImage(
                  imageUrl: 'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              movie.title,
              style: Theme.of(context).textTheme.titleSmall
            ),
            const SizedBox(height: 10,),
            Container(
              width: 300,
              child: RatingStars(
                value: movie.voteAverage/2,
                starSize: 15,
                maxValue: 5,
                valueLabelColor: Styles.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
