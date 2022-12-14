import 'package:flutter/material.dart';
import 'package:movies_db/Library/Widgets/Inherited/provider.dart';
import 'package:movies_db/domain/api_client/api_client.dart';
import 'package:movies_db/ui/Theme/app_colors.dart';
import 'package:movies_db/ui/widgets/movie_list/movie_list_model.dart';

class MovieListWidget extends StatelessWidget {
  const MovieListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieListModel>(context);
    if (model == null) return const SizedBox.shrink();
    return Stack(
      children: [
        ListView.builder(
            padding: const EdgeInsets.only(top: 49),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemCount: model.movies.length,
            itemExtent: 163,
            itemBuilder: (BuildContext context, int index) {
              model.showedMovieAtIndex(index);
              final movie = model.movies[index];
              final posterPath = movie.posterPath;
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: Colors.black.withOpacity(0.2)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
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
                          posterPath != null
                              ? Image.network(
                                  ApiClient.imageUrl(posterPath),
                                  width: 95,
                                )
                              : const SizedBox.shrink(),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 15),
                                Text(
                                  movie.title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  model.stringFromDate(movie.releaseDate),
                                  style: const TextStyle(color: Colors.grey),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  movie.overview,
                                  maxLines: 3,
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        overlayColor: MaterialStateProperty.all(
                            AppColors.mainDarkBlue.withOpacity(0.3)),
                        onTap: () => model.onMovieTap(context, index),
                      ),
                    ),
                  ],
                ),
              );
            }),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            onChanged: model.searchMovie,
            cursorColor: AppColors.mainDarkBlue,
            decoration: InputDecoration(
              isCollapsed: true,
              contentPadding: const EdgeInsets.all(10),
              hintText: '???????????????? ????????????',
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
