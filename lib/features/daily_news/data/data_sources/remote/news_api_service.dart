import 'package:retrofit/retrofit.dart';
import 'package:riverpod_learn/core/constants/constants.dart';
import 'package:riverpod_learn/features/daily_news/data/models/article.dart';
import 'package:dio/dio.dart';

part 'news_api_service.g.dart';

@RestApi(baseUrl: newsAPIBaseUrl)
abstract class NewsApiService {
  factory NewsApiService(Dio dio) = _NewsApiService;

  @GET('/top-headlines')
  Future<HttpResponse<List<ArticleModel>>> getNewsArticles(
      {@Query('apiKey') String? apiKey,
      @Query('country') String? country,
      @Query('category') String? category});
}
