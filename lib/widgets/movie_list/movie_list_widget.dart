import 'package:flutter/material.dart';
import 'package:movies_db/Theme/app_colors.dart';
import 'package:movies_db/resources/resources.dart';
import 'package:movies_db/widgets/movie_details/movie_details_widget.dart';

class MovieListWidget extends StatefulWidget {
  const MovieListWidget({Key? key}) : super(key: key);

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  final List<Movie> _movies = [
    Movie(
        id: 1,
        imageName: AppImages.minions,
        title: 'Миньоны: Грювитация',
        time: '29 июня 2022',
        description:
            'Миллион лет миньоны искали самого великого и ужасного предводителя, пока не встретили ЕГО. Знакомьтесь - Грю. Пусть он еще очень молод, но у него в планах по-настоящему гадкие дела, которые заставят планету содрогнуться.'),
    Movie(
        id: 2,
        imageName: AppImages.minions,
        title: 'Миньоны: Грювитация GG',
        time: '29 июня 2022',
        description:
            'Миллион лет миньоны искали самого великого и ужасного предводителя, пока не встретили ЕГО. Знакомьтесь - Грю. Пусть он еще очень молод, но у него в планах по-настоящему гадкие дела, которые заставят планету содрогнуться.'),
    Movie(
        id: 3,
        imageName: AppImages.minions,
        title: 'Миньоны: Грювитация 4',
        time: '29 июня 2022',
        description:
            'Миллион лет миньоны искали самого великого и ужасного предводителя, пока не встретили ЕГО. Знакомьтесь - Грю. Пусть он еще очень молод, но у него в планах по-настоящему гадкие дела, которые заставят планету содрогнуться.'),
    Movie(
        id: 4,
        imageName: AppImages.minions,
        title: 'Миньоны: Грювитация FFFFF',
        time: '29 июня 2022',
        description:
            'Миллион лет миньоны искали самого великого и ужасного предводителя, пока не встретили ЕГО. Знакомьтесь - Грю. Пусть он еще очень молод, но у него в планах по-настоящему гадкие дела, которые заставят планету содрогнуться.'),
    Movie(
        id: 5,
        imageName: AppImages.minions,
        title: 'Миньоны: Грювитация xxxxx',
        time: '29 июня 2022',
        description:
            'Миллион лет миньоны искали самого великого и ужасного предводителя, пока не встретили ЕГО. Знакомьтесь - Грю. Пусть он еще очень молод, но у него в планах по-настоящему гадкие дела, которые заставят планету содрогнуться.'),
  ];

  late List<Movie> _filteredMovies;

  final _searchController = TextEditingController();

  void _searchMovies() {
    final String query = _searchController.text;
    if (query.isNotEmpty) {
      _filteredMovies = _movies.where((Movie movie) {
        return movie.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      _filteredMovies = _movies;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _filteredMovies = _movies;
    _searchController.addListener(_searchMovies);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
            padding: const EdgeInsets.only(top: 49),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemCount: _filteredMovies.length,
            itemExtent: 163,
            itemBuilder: (BuildContext context, int index) {
              final movie = _filteredMovies[index];
              return Tile(
                movie: movie,
                navigator: () {
                  Navigator.pushNamed(context, MovieDetailsWidget.id,
                      arguments: movie.id);
                },
              );
            }),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: _searchController,
            cursorColor: AppColors.mainDarkBlue,
            decoration: InputDecoration(
              isCollapsed: true,
              contentPadding: const EdgeInsets.all(10),
              hintText: 'Название фильма',
              filled: true,
              fillColor: Colors.white.withAlpha(235),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Tile extends StatelessWidget {
  final Movie movie;
  final Function() navigator;

  // ignore: use_key_in_widget_constructors
  const Tile({required this.movie, required this.navigator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black.withOpacity(0.2)),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  )
                ]),
            clipBehavior: Clip.hardEdge,
            child: Row(
              children: [
                Image(
                  image: AssetImage(movie.imageName),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        movie.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        movie.time,
                        style: const TextStyle(color: Colors.grey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        movie.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              overlayColor: MaterialStateProperty.all(
                  AppColors.mainDarkBlue.withOpacity(0.3)),
              onTap: () => navigator(),
            ),
          ),
        ],
      ),
    );
  }
}

class Movie {
  final int id;
  final String imageName;
  final String title;
  final String time;
  final String description;

  Movie({
    required this.id,
    required this.imageName,
    required this.title,
    required this.time,
    required this.description,
  });
}
