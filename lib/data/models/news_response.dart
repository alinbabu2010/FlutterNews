import 'articles.dart';

class NewsResponse {
  NewsResponse({
    String? status,
    num? totalResults,
    List<Article>? articles,
  }) {
    _status = status;
    _totalResults = totalResults;
    _articles = articles;
  }

  NewsResponse.fromJson(dynamic json) {
    _status = json['status'];
    _totalResults = json['totalResults'];
    if (json['articles'] != null) {
      _articles = [];
      json['articles'].forEach((v) {
        _articles?.add(Article.fromJson(v));
      });
    }
  }

  String? _status;
  num? _totalResults;
  List<Article>? _articles;

  NewsResponse copyWith({
    String? status,
    num? totalResults,
    List<Article>? articles,
  }) =>
      NewsResponse(
        status: status ?? _status,
        totalResults: totalResults ?? _totalResults,
        articles: articles ?? _articles,
      );

  String? get status => _status;

  num? get totalResults => _totalResults;

  List<Article>? get articles => _articles;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['totalResults'] = _totalResults;
    if (_articles != null) {
      map['articles'] = _articles?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
