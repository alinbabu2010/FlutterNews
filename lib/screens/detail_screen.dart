import 'package:flutter/material.dart';
import 'package:flutter_news/data/models/articles.dart';
import 'package:flutter_news/utils/constants.dart';
import 'package:flutter_news/widgets/article_detail.dart';
import 'package:intl/intl.dart';

import '../utils/dimensions.dart';

class DetailScreen extends StatelessWidget {
  final Article article;

  const DetailScreen({Key? key, required this.article}) : super(key: key);

  SizedBox buildSizedBox() => const SizedBox(height: Dimens.spacingHeight);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: article.publishedAt ?? Constants.heroTag,
            child: Image.network(
              article.urlToImage ?? "",
              width: double.infinity,
              height: deviceSize.height * Dimens.imageHeightPercentage,
              fit: BoxFit.cover,
              errorBuilder: (_, error, trace) {
                return Image.asset(
                  Constants.placeHolderPath,
                  width: double.infinity,
                  height: deviceSize.height * Dimens.imageHeightPercentage,
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: deviceSize.height * Dimens.contentMarginPercentage,
            ),
            height: double.infinity,
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(Dimens.contentBorderRadius),
                topLeft: Radius.circular(Dimens.contentBorderRadius),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(Dimens.contentPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title!,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineSmall,
                    ),
                    buildSizedBox(),
                    if (article.author != null)
                      Text(
                        "${Constants.labelAuthor}: ${article.author}",
                        style: theme.textTheme.labelLarge,
                      ),
                    buildSizedBox(),
                    if (article.publishedAt != null)
                      Text(
                        "${Constants.labelPublishedOn}: ${DateFormat.yMMMMd().format(
                          DateTime.parse(article.publishedAt!),
                        )}",
                        style: theme.textTheme.labelLarge,
                      ),
                    buildSizedBox(),
                    ArticleInfo(
                      title: Constants.labelDescription,
                      body: article.description ?? "",
                    ),
                    buildSizedBox(),
                    ArticleInfo(
                      title: Constants.labelContent,
                      body: article.content ?? "",
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
