import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_news/utils/constants.dart';
import 'package:flutter_news/widgets/article_list.dart';
import 'package:provider/provider.dart';

import '../provider/news_provider.dart';
import '../provider/news_state.dart';
import '../widgets/progress_bar.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void initState() {
    super.initState();
    Provider.of<NewsProvider>(context, listen: false).fetchData();
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
          if (newsState.status == Status.loading) {
            return const ProgressBar();
          } else if (newsState.status == Status.failure) {
            if (newsState.articles == null ||
                newsState.articles?.isEmpty == true) {
              final textTheme = Theme.of(context).textTheme.bodyLarge;
              return Center(
                child: Text(
                  newsState.message!,
                  style: textTheme?.copyWith(color: Colors.redAccent),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                _showSnackBar(newsState.message!);
              });
            }
          }
          return ArticleList(
            articles: newsState.articles ?? [],
            status: newsState.status,
          );
        },
      ),
    );
  }
}
