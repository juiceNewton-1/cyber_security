import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cyber_security/generated/assets.gen.dart';
import 'package:cyber_security/helpers/date_time_helper.dart';
import 'package:cyber_security/models/arguments.dart';
import 'package:cyber_security/models/article.dart';
import 'package:cyber_security/theme/custom_colors.dart';
import 'package:cyber_security/widgets/components/article_cover.dart';

class ArticleView extends StatelessWidget {
  final ArticleViewArguments arguments;
  const ArticleView({super.key, required this.arguments});

  factory ArticleView.ceate(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as ArticleViewArguments;
    return ArticleView(arguments: arguments);
  }

  Article get _article => arguments.article;

  @override
  Widget build(BuildContext context) {
    final hours = DateTimeHelper.getHours(_article.date);
    final minutes = DateTimeHelper.getMinutes(_article.date);
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Assets.icons.back.svg(),
          onPressed: Navigator.of(context).pop,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 335 / 188,
              child: ArtcileCover(url: _article.imageUrl),
            ),
            SizedBox(height: 18),
            Text(
              _article.title,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Today, ${hours}:$minutes',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w400,
                    color:
                        Theme.of(context).extension<CustomColors>()!.dateColor,
                  ),
            ),
            SizedBox(height: 22),
            Text(
              _article.body,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}
