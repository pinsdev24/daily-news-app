import 'package:riverpod_learn/core/resources/data_state.dart';
import 'package:riverpod_learn/features/daily_news/domain/entities/article_entity.dart';

abstract class ArticleRepository {
  //Remote
  Future<DataState<List<ArticleEntity>>> getNewsArticles();

  //Local
  Future<void> saveArticle(ArticleEntity article);
  Future<void> removeArticle(ArticleEntity article);
  Future<List<ArticleEntity>> getSavedArticles();
}
