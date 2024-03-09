import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:riverpod_learn/features/daily_news/domain/entities/article_entity.dart';
import 'package:riverpod_learn/features/daily_news/domain/usecaces/get_saved_article.dart';
import 'package:riverpod_learn/features/daily_news/domain/usecaces/remove_article.dart';
import 'package:riverpod_learn/features/daily_news/domain/usecaces/save_article.dart';

part 'local_article_event.dart';
part 'local_article_state.dart';

class LocalArticleBloc extends Bloc<LocalArticleEvent, LocalArticleState> {
  final GetSavedArticleUseCase _getSavedArticleUseCase;
  final SaveArticleUseCase _saveArticleUseCase;
  final RemoveArticleUseCase _removeArticleUseCase;

  LocalArticleBloc(this._getSavedArticleUseCase, this._saveArticleUseCase,
      this._removeArticleUseCase)
      : super(const LocalArticlesLoading()) {
    on<GetSavedArticles>(onGetSavedArticles);
    on<SaveArticle>(onSaveArticle);
    on<RemoveArticle>(onRemoveArticles);
  }

  onGetSavedArticles(
      GetSavedArticles event, Emitter<LocalArticleState> emit) async {
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticlesDone(articles));
  }

  onSaveArticle(
      SaveArticle saveArticle, Emitter<LocalArticleState> emit) async {
    await _saveArticleUseCase(params: saveArticle.article);
    final articles = await _getSavedArticleUseCase();

    emit(LocalArticlesDone(articles));
  }

  onRemoveArticles(
      RemoveArticle removeArticle, Emitter<LocalArticleState> emit) async {
    await _removeArticleUseCase(params: removeArticle.article);
    final articles = await _getSavedArticleUseCase();

    emit(LocalArticlesDone(articles));
  }
}
