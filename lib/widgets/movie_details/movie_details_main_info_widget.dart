import 'package:flutter/material.dart';
import 'package:movies_db/resources/resources.dart';
import 'package:movies_db/widgets/movie_details/score_indicate_painter.dart';

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
        const SizedBox(height: 30),
        const _PeopleWidget()
      ],
    );
  }
}

class _TopPosterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        Image(image: AssetImage(AppImages.fullScreenMinions)),
        Positioned(
            top: 20,
            bottom: 20,
            left: 20,
            child: Image(image: AssetImage(AppImages.minions))),
      ],
    );
  }
}

class _MovieNameWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 3,
      textAlign: TextAlign.center,
      text: const TextSpan(
        children: [
          TextSpan(
            text: 'Миньоны: Грювитация ',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
          ),
          TextSpan(
            text: ' (2022)',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _ScoreWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {},
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: ScoreIndicator(
                          percent: 0.73,
                          textSize: 20,
                          textWeight: FontWeight.w700,
                          textColor: Colors.white),
                    ),
                  ),
                  SizedBox(width: 2),
                  Text(
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
    return Container(
      width: double.infinity,
      color: const Color.fromRGBO(22, 21, 25, 1.0),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 60, vertical: 40),
        child: Text(
          'PG 01/07/2022 (US) семейный, мультфильм, приключения, комедия, фэнтези 1h 27m',
          maxLines: 3,
          textAlign: TextAlign.center,
          style: TextStyle(
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
        'Обзор',
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
    return const Text(
      'Миллион лет миньоны искали самого великого и ужасного предводителя, пока не встретили ЕГО. Знакомьтесь - Грю. Пусть он еще очень молод, но у него в планах по-настоящему гадкие дела, которые заставят планету содрогнуться.',
      style: TextStyle(
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
