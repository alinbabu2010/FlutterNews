import '../data/models/articles.dart';

class NewsState {
  List<Article>? articles;
  Status status;
  String? message;

  NewsState(this.status, {this.articles, this.message});

  NewsState copyWith({
    List<Article>? articles,
    Status? status,
    String? message,
  }) =>
      NewsState(
        status ?? this.status,
        articles: articles ?? this.articles,
        message: message ?? this.message,
      );
}

enum Status { loading, refreshing, success, failure, loadMore, noMoreData }
