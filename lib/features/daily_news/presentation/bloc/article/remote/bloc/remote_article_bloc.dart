import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:riverpod_learn/core/resources/data_state.dart';
import 'package:riverpod_learn/features/daily_news/domain/entities/article_entity.dart';
import 'package:riverpod_learn/features/daily_news/domain/usecaces/get_article.dart';

part 'remote_article_event.dart';
part 'remote_article_state.dart';

class RemoteArticleBloc extends Bloc<RemoteArticleEvent, RemoteArticleState> {
  final GetArticleUseCase _getArticleUseCase;
  RemoteArticleBloc(this._getArticleUseCase)
      : super(const RemoteArticlesLoading()) {
    on<GetArticles>((event, emit) async {
      final dataState = await _getArticleUseCase();

      if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
        emit(RemoteArticlesDone(dataState.data!));
      }

      if (dataState is DataFailed) {
        emit(RemoteArticlesError(dataState.error!));
      }
    });
  }
}
