import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:cyber_security/helpers/constants.dart';
import 'package:cyber_security/models/article.dart';

class ArticlesApiService {
  static const _url = 'https://google-api31.p.rapidapi.com/';

  Future<List<Article>> getArticles() async {
    try {
      List<Article> articles = [];
      final data = {
        "text": "Cyber security",
        "region": "wt-wt",
        "max_results": 20,
        "time_limit": "d"
      };
      final response = await post(
        Uri.parse(_url),
        headers: {
          'X-RapidAPI-Key': Constants.articlesApiKey,
          'X-RapidAPI-Host': Constants.arrticlesApiHost
        },
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log(data.toString());
        final json = data['news'] as List<dynamic>;
        for (var articleJson in json) {
          articles.add(Article.fromJson(articleJson));
        }
        return articles;
      }
      else {
        log(response.statusCode.toString());
        throw Exception('Status code: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
