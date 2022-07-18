import 'package:flutter/material.dart';

import 'movie_details_main_info_widget.dart';
import 'movie_details_main_screen_cast_widget.dart';

class MovieDetailsWidget extends StatefulWidget {
  final int movieId;
  // ignore: use_key_in_widget_constructors
  const MovieDetailsWidget({required this.movieId});

  @override
  State<MovieDetailsWidget> createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TMDB'),
      ),
      body: ColoredBox(
        color: const Color.fromRGBO(24, 23, 27, 1.0),
        child: ListView(
          children: const [
            MovieDetailsMainInfoWidget(),
            MovieDetailsMainScreenCastWidget(),
          ],
        ),
      ),
    );
  }
}
