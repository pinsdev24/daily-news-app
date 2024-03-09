import 'dart:io';

import 'package:dio/dio.dart';
import 'package:riverpod_learn/core/constants/constants.dart';
import 'package:riverpod_learn/core/resources/data_state.dart';
import 'package:riverpod_learn/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:riverpod_learn/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:riverpod_learn/features/daily_news/data/models/article.dart';
import 'package:riverpod_learn/features/daily_news/domain/entities/article_entity.dart';
import 'package:riverpod_learn/features/daily_news/domain/repository/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService;
  final AppDatabase _appDatabase;

  ArticleRepositoryImpl(this._newsApiService, this._appDatabase);

  @override
  Future<DataState<List<ArticleEntity>>> getNewsArticles() async {
    try {
      final httpResponse = await _newsApiService.getNewsArticles(
          apiKey: apiKey, country: country, category: category);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
            requestOptions: httpResponse.response.requestOptions,
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<List<ArticleModel>> getSavedArticles() {
    return _appDatabase.articleDao.getArticles();
  }

  @override
  Future<void> removeArticle(ArticleEntity article) async {
    _appDatabase.articleDao.deleteArticle(ArticleModel.fromEntity(article));
  }

  @override
  Future<void> saveArticle(ArticleEntity article) async {
    _appDatabase.articleDao.insertArticle(ArticleModel.fromEntity(article));
  }
}
