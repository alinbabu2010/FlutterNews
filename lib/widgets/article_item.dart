import 'package:flutter/material.dart';
import 'package:flutter_news/screens/detail_screen.dart';
import 'package:flutter_news/utils/constants.dart';
import 'package:flutter_news/utils/dimensions.dart';

import '../data/models/articles.dart';

class ArticleItem extends StatelessWidget {
  final Article article;

  const ArticleItem({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimens.itemLeftPadding,
        right: Dimens.itemRightPadding,
        bottom: Dimens.itemBottomPadding,
      ),
      child: Material(
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.itemTileBorderRadius),
          ),
          tileColor: Colors.amberAccent,
          leading: Hero(
            tag: article.publishedAt ?? Constants.heroTag,
            child: CircleAvatar(
              radius: Dimens.itemAvatarRadius,
              foregroundImage: article.urlToImage != null
                  ? NetworkImage((article.urlToImage)!)
                  : null,
              backgroundImage: const AssetImage(Constants.placeHolderPath),
              backgroundColor: Colors.black26,
            ),
          ),
          title: Text(
            article.title ?? "",
            maxLines: Dimens.itemTitleMaxLines,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Text(
            article.description ?? "",
            maxLines: Dimens.itemSubTitleMaxLines,
            overflow: TextOverflow.ellipsis,
          ),
          isThreeLine: true,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => DetailScreen(article: article),
                  fullscreenDialog: true),
            );
          },
        ),
      ),
    );
  }
}
