import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:cyber_security/models/article.dart';
import 'package:cyber_security/services/articles_api_service.dart';

class ArticlesController extends ValueNotifier<ArticlesState> {
  ArticlesController() : super(ArticlesState.inital()) {
    _init();
  }

  final _articlesApiService = GetIt.instance<ArticlesApiService>();

  Future<void> _init() async {
    try {
      value = value.copyWith(isLoading: true);
      final articles = await _articlesApiService.getArticles();
      value = value.copyWith(isLoading: false, articles: articles);
    } catch (e) {
      value = value.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> refresh() async => await _init();
}

class ArticlesState {
  final List<Article> articles;
  final bool isLoading;
  final String? errorMessage;

  const ArticlesState({
    required this.articles,
    required this.isLoading,
    this.errorMessage,
  });

  factory ArticlesState.inital() => ArticlesState(
        articles: [],
        isLoading: false,
      );

  ArticlesState copyWith({
    List<Article>? articles,
    bool? isLoading,
    String? errorMessage,
  }) =>
      ArticlesState(
        articles: articles ?? this.articles,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
