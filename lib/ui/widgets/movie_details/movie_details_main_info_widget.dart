import 'package:flutter/material.dart';
import 'package:movies_db/Library/Widgets/Inherited/provider.dart';
import 'package:movies_db/domain/api_client/api_client.dart';
import 'package:movies_db/domain/entity/movie_details.dart';
import 'package:movies_db/domain/entity/movie_details_credits.dart';
import 'package:movies_db/ui/navigation/main_navigation.dart';
import 'package:movies_db/ui/widgets/movie_details/score_indicate_widget.dart';

import 'movie_details_model.dart';

class MovieDetailsMainInfoWidget extends StatelessWidget {
  const MovieDetailsMainInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _TopPosterWidget(),
        Padding(
          padding: const EdgeInsets.all(25),
          child: _MovieNameWidget(),
        ),
        SizedBox(height: 90, child: _ScoreWidget()),
        _SummeryWidget(),
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: _OverviewWidget(),
        ),
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: _DescriptionWidget(),
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: _PeopleWidget(),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}

class _TopPosterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final backdropPath = model?.movieDetails?.backdropPath;
    final posterPath = model?.movieDetails?.posterPath;
    return AspectRatio(
      aspectRatio: 390 / 219,
      child: Stack(
        children: [
          backdropPath != null
              ? Image.network(ApiClient.imageUrl(backdropPath))
              : const SizedBox.shrink(),
          Positioned(
            top: 20,
            bottom: 20,
            left: 20,
            child: posterPath != null
                ? Image.network(ApiClient.imageUrl(posterPath))
                : const SizedBox.shrink(),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: IconButton(
              onPressed: model?.toggleFavorite,
              icon: Icon(
                model?.isFavorite == true
                    ? Icons.favorite
                    : Icons.favorite_outline,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _MovieNameWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    dynamic year = model?.movieDetails?.releaseDate?.year.toString();
    year = year != null ? '   ($year)' : '';
    return Center(
      child: RichText(
        maxLines: 3,
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: model?.movieDetails?.title ?? '',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
            ),
            TextSpan(
              text: year,
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScoreWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movieDetails =
        NotifierProvider.watch<MovieDetailsModel>(context)?.movieDetails;
    final double voteAverage = movieDetails?.voteAverage ?? 0.0;
    final videos = movieDetails?.videos.results
        .where((video) => video.type == 'Trailer' && video.site == 'YouTube');
    final trailerKey = videos?.isNotEmpty == true ? videos!.first.key : null;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {},
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: ScoreIndicator(
                          percent: voteAverage / 10,
                          textSize: 20,
                          textWeight: FontWeight.w700,
                          textColor: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 2),
                  const Text(
                    'User Score',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    // style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ),
        const VerticalDivider(
          thickness: 1,
          color: Colors.grey,
          indent: 20,
          endIndent: 20,
        ),
        Expanded(
          child: trailerKey != null
              ? TextButton(
                  onPressed: () => Navigator.of(context).pushNamed(
                    MainNavigationRouteNames.movieTrailerWidget,
                    arguments: trailerKey,
                  ),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.play_arrow,
                          size: 20,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Play Trailer',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class _SummeryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    if (model == null) return const SizedBox.shrink();
    List<String> texts = [];
    final releaseDate = model.movieDetails?.releaseDate;
    if (releaseDate != null) {
      texts.add(model.stringFromDate(releaseDate));
    }
    final productionCountries = model.movieDetails?.productionCountries;
    if (productionCountries != null && productionCountries.isNotEmpty) {
      texts.add('(${productionCountries.first.iso})');
    }

    final runtime = model.movieDetails?.runtime ?? 0;
    final duration = Duration(minutes: runtime);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    texts.add('${hours}h ${minutes}m');

    final List<Genre>? genres = model.movieDetails?.genres;
    if (genres != null && genres.isNotEmpty) {
      List<String> genresName = [];
      for (Genre genre in genres) {
        genresName.add(genre.name);
      }
      texts.add(genresName.join(', '));
    }

    return Container(
      width: double.infinity,
      color: const Color.fromRGBO(22, 21, 25, 1.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Text(
          texts.join('  '),
          // 'PG 01/07/2022 (US) семейный, мультфильм, приключения, комедия, фэнтези 1h 27m',
          maxLines: 3,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}

class _OverviewWidget extends StatelessWidget {
  const _OverviewWidget();
  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Overview',
        style: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
      ),
    );
  }
}

class _DescriptionWidget extends StatelessWidget {
  const _DescriptionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    return Text(
      model?.movieDetails?.overview ?? '',
      style: const TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
    );
  }
}

class _PeopleWidget extends StatelessWidget {
  const _PeopleWidget();

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    List<Employee>? crew = model?.movieDetails?.credits.crew;
    if (crew == null || crew.isEmpty) return const SizedBox.shrink();
    crew = crew.length >= 4 ? crew.sublist(0, 4) : crew;
    List<List<Employee>> crewChunks = [];
    for (int i = 0; i < crew.length; i += 2) {
      crewChunks.add(
        crew.sublist(i, i + 2 > crew.length ? crew.length : i + 2),
      );
    }
    return Column(
      children: crewChunks
          .map(
            (chunk) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _PeopleWidgetColumn(employees: chunk),
            ),
          )
          .toList(),
    );
  }
}

class _PeopleWidgetColumn extends StatelessWidget {
  final List<Employee> employees;
  const _PeopleWidgetColumn({Key? key, required this.employees})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: employees
          .map(
            (employee) => _PeopleWidgetColumnItem(
              employee: employee,
            ),
          )
          .toList(),
    );
  }
}

class _PeopleWidgetColumnItem extends StatelessWidget {
  final Employee employee;
  const _PeopleWidgetColumnItem({Key? key, required this.employee})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const nameStyle = TextStyle(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400);
    const jobTitleStyle = TextStyle(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400);
    const nameCrossAxisColumnAlignment = CrossAxisAlignment.start;
    return Expanded(
      child: Column(
        crossAxisAlignment: nameCrossAxisColumnAlignment,
        children: [
          Text(employee.originalName, style: nameStyle),
          Text(employee.job, style: jobTitleStyle),
        ],
      ),
    );
  }
}
