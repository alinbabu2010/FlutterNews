import 'package:flutter/cupertino.dart';
import 'package:flutter_news/data/models/news_response.dart';
import 'package:flutter_news/data/remote/remote_source.dart';
import 'package:flutter_news/provider/news_state.dart';

import '../data/models/articles.dart';

class NewsProvider with ChangeNotifier {
  /// Current Page to get Data from API
  int _page = 1;

  /// Total Pages of Data from API.
  //  Based on API restriction we can get only 90 results for time being
  final int _totalResults = 90;

  NewsProvider() {
    fetchData();
  }

  NewsState _newsState = NewsState(Status.loading);

  NewsState get newsState => _newsState;

  List<Article> get _articles => _newsState.articles ?? List.empty();

  Future<void> fetchData({bool isRefresh = false}) async {
    if (!isRefresh) {
      _newsState = _newsState.copyWith(
          status: _newsState.isLoading ? _newsState.status : Status.loadMore);
      _page++;
    } else {
      _resetParams();
    }
    notifyListeners();
    try {
      if (!_isLoadMoreAvailable && !isRefresh) {
        _newsState = _newsState.copyWith(status: Status.noMoreData);
      } else {
        final response = await NetworkDataSource().fetchNews(_page);
        _setParams(response, isRefresh);
      }
    } on Exception catch (exception) {
      _newsState = _newsState.copyWith(
        status: Status.failure,
        message: exception.toString(),
      );
    }
    notifyListeners();
  }

  void _resetParams() {
    _page = 1;
    _newsState = _newsState.copyWith(status: Status.refreshing);
  }

  bool get _isLoadMoreAvailable =>
      _articles.isEmpty || _articles.length < _totalResults;

  void _setParams(NewsResponse response, bool isRefresh) {
    //_totalResults = response.totalResults?.toInt() ?? 0;
    if (isRefresh || _page == 1) {
      _newsState = NewsState(Status.success, articles: response.articles);
    } else {
      _newsState = _newsState.copyWith(
          status: Status.success, articles: _getArticles(response));
    }
  }

  List<Article>? _getArticles(NewsResponse response) {
    if (_articles.isEmpty) {
      return response.articles;
    } else {
      _articles.addAll(response.articles ?? []);
      return _articles;
    }
  }
}
