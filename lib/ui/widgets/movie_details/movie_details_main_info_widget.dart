import 'package:flutter/material.dart';
import 'package:movies_db/Library/Widgets/Inherited/provider.dart';
import 'package:movies_db/domain/api_client/api_client.dart';
import 'package:movies_db/domain/entity/movie_details.dart';
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
        const _PeopleWidget(),
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
    double voteAverage = movieDetails?.voteAverage ?? 0.0;

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
          child: TextButton(
            onPressed: () {},
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
          ),
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
    const nameStyle = TextStyle(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400);
    const jobTitleStyle = TextStyle(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400);
    const nameCrossAxisColumnAlignment = CrossAxisAlignment.start;
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Column(
              crossAxisAlignment: nameCrossAxisColumnAlignment,
              children: const [
                Text(
                  'Matt Fogel',
                  style: nameStyle,
                ),
                Text(
                  'Matt ',
                  style: jobTitleStyle,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: nameCrossAxisColumnAlignment,
              children: const [
                Text(
                  'Kyle Balda',
                  style: nameStyle,
                ),
                Text(
                  'Kyle',
                  style: jobTitleStyle,
                ),
              ],
            ),
          ],
        ),
        Column(
          children: [
            Column(
              crossAxisAlignment: nameCrossAxisColumnAlignment,
              children: const [
                Text(
                  'Kyle Balda',
                  style: nameStyle,
                ),
                Text(
                  'Kyle Balda',
                  style: jobTitleStyle,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: nameCrossAxisColumnAlignment,
              children: const [
                Text(
                  'Brian Lynch',
                  style: nameStyle,
                ),
                Text(
                  'Brian Lynch',
                  style: jobTitleStyle,
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
