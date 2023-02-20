import 'package:flutter/material.dart';
import 'package:flutter_news/utils/dimensions.dart';

class ArticleInfo extends StatelessWidget {
  final String title;
  final String body;

  const ArticleInfo({Key? key, required this.title, required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.start,
          style: textTheme.titleLarge,
        ),
        const SizedBox(height: Dimens.titleSpacing),
        Text(
          body,
          textAlign: TextAlign.start,
          style: textTheme.bodyMedium,
        )
      ],
    );
  }
}
