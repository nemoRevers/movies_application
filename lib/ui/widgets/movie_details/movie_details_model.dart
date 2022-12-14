import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:movies_db/domain/api_client/api_client.dart';
import 'package:movies_db/domain/entity/movie_details.dart';
import 'package:movies_db/domain/providers/session_data_provider.dart';

class MovieDetailsModel extends ChangeNotifier {
  final _sessionDataProvider = SessionDataProvider();
  final _apiClient = ApiClient();

  final int movieId;
  MovieDetails? _movieDetails;
  bool _isFavorite = false;
  String _locale = '';
  late DateFormat _dateFormat;

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  MovieDetails? get movieDetails => _movieDetails;
  bool get isFavorite => _isFavorite;

  MovieDetailsModel(this.movieId);

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    await loadDetails();
  }

  Future<void> loadDetails() async {
    _movieDetails = await _apiClient.movieDetails(movieId, _locale);
    final sessionId = await _sessionDataProvider.getSessionId();
    if (sessionId != null) {
      _isFavorite = await _apiClient.isFavorite(movieId, sessionId);
    }
    notifyListeners();
  }

  Future<void> toggleFavorite() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    final accountId = await _sessionDataProvider.getAccountId();

    if (sessionId == null || accountId == null) return;

    _isFavorite = !_isFavorite;
    notifyListeners();
    await _apiClient.markAsFavorite(
      accountId: accountId,
      sessionId: sessionId,
      mediaType: MediaType.Movie,
      mediaId: movieId,
      isFavorite: _isFavorite,
    );
  }
}
