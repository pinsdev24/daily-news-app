import 'package:floor/floor.dart';
import 'package:riverpod_learn/features/daily_news/domain/entities/article_entity.dart';

@Entity(tableName: 'article', primaryKeys: ['id'])
class ArticleModel extends ArticleEntity {
  const ArticleModel(
      {super.id,
      super.author,
      super.title,
      super.content,
      super.description,
      super.url,
      super.urlToImage,
      super.publishedAt});

  factory ArticleModel.fromJson(Map<String, dynamic> data) => ArticleModel(
      author: data['author'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      url: data['url'] ?? '',
      urlToImage: data['urlToImage'] ?? '',
      publishedAt: data['publishedAt'] ?? '',
      content: data['content'] ?? '');

  factory ArticleModel.fromEntity(ArticleEntity entity) => ArticleModel(
      id: entity.id,
      author: entity.author,
      title: entity.title,
      description: entity.description,
      url: entity.url,
      urlToImage: entity.urlToImage,
      publishedAt: entity.publishedAt,
      content: entity.content);
}
