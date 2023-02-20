import 'package:flutter/material.dart';
import 'package:flutter_news/data/models/articles.dart';
import 'package:flutter_news/provider/news_provider.dart';
import 'package:flutter_news/utils/constants.dart';
import 'package:flutter_news/utils/dimensions.dart';
import 'package:flutter_news/widgets/article_item.dart';
import 'package:flutter_news/widgets/error_widget.dart';
import 'package:flutter_news/widgets/progress_bar.dart';
import 'package:provider/provider.dart';

import '../provider/news_state.dart';

class ArticleList extends StatefulWidget {
  final List<Article> articles;
  final NewsState state;

  const ArticleList({super.key, required this.articles, required this.state});

  @override
  State<ArticleList> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.position.maxScrollExtent ==
        scrollController.position.pixels) {
      if (!widget.state.isLoadMore) {
        Provider.of<NewsProvider>(context, listen: false).fetchData();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.only(top: Dimens.listTopPadding),
      itemBuilder: (context, index) {
        final article =
            index < widget.articles.length ? widget.articles[index] : null;
        return article != null
            ? ArticleItem(article: article)
            : widget.state.isNoMoreData
                ? const EmptyMsgWidget(
                    message: Constants.noMoreData,
                    isScrollNeeded: false,
                  )
                : const ProgressBar();
      },
      itemCount: widget.state.isLoadMore
          ? widget.articles.length + 1
          : widget.articles.length,
    );
  }
}
