part of 'remote_article_bloc.dart';

sealed class RemoteArticleState extends Equatable {
  final List<ArticleEntity>? data;
  final DioException? error;
  const RemoteArticleState({this.data, this.error});

  @override
  List<Object> get props => [data!, error!];
}

final class RemoteArticleInitial extends RemoteArticleState {}

final class RemoteArticlesLoading extends RemoteArticleState {
  const RemoteArticlesLoading();
}

final class RemoteArticlesDone extends RemoteArticleState {
  const RemoteArticlesDone(List<ArticleEntity> article) : super(data: article);
}

final class RemoteArticlesError extends RemoteArticleState {
  const RemoteArticlesError(DioException error) : super(error: error);
}
