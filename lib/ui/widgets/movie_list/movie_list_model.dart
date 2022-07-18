import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:movies_db/domain/api_client/api_client.dart';
import 'package:movies_db/domain/entity/movie.dart';
import 'package:movies_db/ui/navigation/main_navigation.dart';

class MovieListModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _movies = <Movie>[];
  late int _currentPage;
  late int _totalPage;
  bool _isLoadingInProgress = false;

  List<Movie> get movies => List.unmodifiable(_movies);
  late DateFormat _dateFormat;
  String _locale = '';

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  void setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _currentPage = 0;
    _totalPage = 1;
    _dateFormat = DateFormat.yMMMMd(locale);
    _movies.clear();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    if (_isLoadingInProgress || _currentPage >= _totalPage) return;
    _isLoadingInProgress = true;
    _currentPage += 1;
    try {
      final moviesResponse =
          await _apiClient.popularMovie(_currentPage, _locale);
      _totalPage = moviesResponse.totalPages;
      _movies.addAll(moviesResponse.movies);
      _isLoadingInProgress = false;
      notifyListeners();
    } catch (_) {
      _isLoadingInProgress = false;
    }
  }

  void onMovieTap(BuildContext context, int index) async {
    final id = _movies[index].id;
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.movieDetails,
      arguments: id,
    );
  }

  void showedMovieAtIndex(int index) {
    if (index < _movies.length - 1) return;
    _loadMovies();
  }
}
