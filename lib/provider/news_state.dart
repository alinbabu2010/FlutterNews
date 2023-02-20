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

  bool get isLoading => status == Status.loading;

  bool get isError => status == Status.failure;

  bool get isRefreshing => status == Status.refreshing;

  bool get isLoadMore => status == Status.loadMore;

  bool get isNoMoreData => status == Status.noMoreData;
}

enum Status { loading, refreshing, success, failure, loadMore, noMoreData }
