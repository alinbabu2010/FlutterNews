import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_news/utils/constants.dart';
import 'package:flutter_news/widgets/error_widget.dart';
import 'package:provider/provider.dart';

import '../provider/news_provider.dart';
import '../provider/news_state.dart';
import '../utils/dimensions.dart';
import '../widgets/article_item.dart';
import '../widgets/progress_bar.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final ScrollController _scrollController = ScrollController();

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.maxScrollExtent ==
        _scrollController.position.pixels) {
      final newsProvider = Provider.of<NewsProvider>(context, listen: false);
      if (!newsProvider.newsState.isLoadMore) {
        newsProvider.fetchData();
      }
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
  }

  Future<void> _onRefresh(bool isLoadingMore) async {
    if (!isLoadingMore) {
      await Provider.of<NewsProvider>(context, listen: false)
          .fetchData(isRefresh: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.labelNews),
        centerTitle: true,
      ),
      body: Consumer<NewsProvider>(
        builder: (context, provider, child) {
          final newsState = provider.newsState;
          final articles = newsState.articles ?? [];
          if (newsState.status == Status.loading) {
            return const ProgressBar();
          } else if (newsState.isError &&
              newsState.articles?.isNotEmpty == true) {
            SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
              _showSnackBar(newsState.message!);
              return;
            });
          }
          return RefreshIndicator(
            onRefresh: () async {
              await _onRefresh(newsState.isLoadMore);
              _scrollToTop();
            },
            child: newsState.isError && newsState.articles?.isEmpty == true
                ? EmptyMsgWidget(
                    message: newsState.message!,
                    isScrollNeeded: true,
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.only(top: Dimens.listTopPadding),
                    itemBuilder: (context, index) {
                      final article =
                          index < articles.length ? articles[index] : null;
                      return article != null
                          ? ArticleItem(article: article)
                          : newsState.isNoMoreData
                              ? const EmptyMsgWidget(
                                  message: Constants.noMoreData,
                                  isScrollNeeded: false,
                                )
                              : const ProgressBar();
                    },
                    itemCount: newsState.isLoadMore || newsState.isNoMoreData
                        ? articles.length + 1
                        : articles.length,
                  ),
          );
        },
      ),
    );
  }
}
