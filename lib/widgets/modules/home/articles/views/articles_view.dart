import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cyber_security/helpers/date_time_helper.dart';
import 'package:cyber_security/models/arguments.dart';
import 'package:cyber_security/models/article.dart';
import 'package:cyber_security/routes/route_names.dart';
import 'package:cyber_security/theme/custom_colors.dart';
import 'package:cyber_security/widgets/components/app_drawer.dart';
import 'package:cyber_security/widgets/components/article_cover.dart';
import 'package:cyber_security/widgets/components/settings_button.dart';
import 'package:cyber_security/widgets/modules/home/articles/controller/articles_controller.dart';

class ArticlesView extends StatefulWidget {
  ArticlesView({super.key});

  @override
  State<ArticlesView> createState() => _ArticlesViewState();
}

class _ArticlesViewState extends State<ArticlesView> {
  late final _articlesController = ArticlesController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() => _scaffoldKey.currentState!.openDrawer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(),
      appBar: AppBar(
        leading: SettingsButton(
          onPressed: _openDrawer,
        ),
        title: Text('News'),
      ),
      body: ValueListenableBuilder(
        valueListenable: _articlesController,
        builder: (context, value, child) {
          if (value.isLoading) {
            return _LoadingState();
          } else {
            if (value.errorMessage != null) {
              return _ErrorState(
                errorMessage: value.errorMessage!,
                refresh: _articlesController.refresh,
              );
            } else {
              return _LoadedState(
                articles: value.articles,
                refresh: _articlesController.refresh,
              );
            }
          }
        },
      ),
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(radius: 20),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String errorMessage;
  final VoidCallback? refresh;
  const _ErrorState({required this.errorMessage, this.refresh});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Error has occured:\n$errorMessage',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 20),
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: Icon(Icons.refresh_outlined, size: 30),
            onPressed: refresh,
          ),
        ],
      ),
    );
  }
}

class _LoadedState extends StatelessWidget {
  final List<Article> articles;
  final VoidCallback? refresh;
  const _LoadedState({
    required this.articles,
    this.refresh,
  });

  @override
  Widget build(BuildContext context) {
    return articles.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Data could not be retrieved.\nPlease, try again',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 20),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Icon(Icons.refresh_outlined, size: 30),
                  onPressed: refresh,
                ),
              ],
            ),
          )
        : ListView.separated(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 20,
            ),
            itemBuilder: (context, index) => _ArticleTile(
              article: articles[index],
            ),
            separatorBuilder: (context, index) => SizedBox(height: 15),
            itemCount: articles.length,
          );
  }
}

class _ArticleTile extends StatelessWidget {
  final Article article;
  const _ArticleTile({required this.article});

  @override
  Widget build(BuildContext context) {
    final hours = DateTimeHelper.getHours(article.date);

    final minutes = DateTimeHelper.getMinutes(article.date);

    return SizedBox(
      height: 70,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () => Navigator.of(context).pushNamed(
          RouteNames.article,
          arguments: ArticleViewArguments(article: article),
        ),
        child: Row(
          children: [
            ArtcileCover(url: article.imageUrl),
            SizedBox(width: 21),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  Text(
                    'Today, ${hours}:$minutes',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context)
                              .extension<CustomColors>()!
                              .dateColor,
                          fontWeight: FontWeight.w500,
                        ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
