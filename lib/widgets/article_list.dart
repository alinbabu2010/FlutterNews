import 'package:flutter/material.dart';
import 'package:flutter_news/data/models/articles.dart';
import 'package:flutter_news/provider/news_provider.dart';
import 'package:flutter_news/utils/constants.dart';
import 'package:flutter_news/utils/dimensions.dart';
import 'package:flutter_news/widgets/article_item.dart';
import 'package:flutter_news/widgets/progress_bar.dart';
import 'package:provider/provider.dart';

import '../provider/news_state.dart';

class ArticleList extends StatefulWidget {
  final List<Article> articles;
  final Status? status;

  const ArticleList({super.key, required this.articles, this.status});

  @override
  State<ArticleList> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  var _isLoadingMore = false;

  void _getData({bool isRefresh = false}) {
    Provider.of<NewsProvider>(context, listen: false)
        .fetchData(isRefresh: isRefresh);
  }

  bool _scrollNotification(ScrollNotification scrollInfo) {
    if (_isLoadingMore == false &&
        scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
      _setLoadingState();
      _getData();
    }
    return true;
  }

  _onRefresh() async {
    if (_isLoadingMore == false) {
      _getData(isRefresh: true);
    }
  }

  _setLoadingState() {
    setState(() {
      _isLoadingMore = !_isLoadingMore;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: _scrollNotification,
            child: RefreshIndicator(
              onRefresh: () async {
                await _onRefresh();
              },
              child: ListView.builder(
                padding: const EdgeInsets.only(top: Dimens.listTopPadding),
                itemBuilder: (context, index) {
                  final article = index < widget.articles.length
                      ? widget.articles[index]
                      : null;
                  return ArticleItem(article: article!);
                },
                itemCount: widget.articles.length,
              ),
            ),
          ),
        ),
        if (widget.status == Status.loadMore) const ProgressBar(),
        if (widget.status == Status.noMoreData)
          const Center(
              child: Text(
            Constants.noMoreData,
            style: TextStyle(
              color: Colors.deepOrangeAccent,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          )),
      ],
    );
  }
}
