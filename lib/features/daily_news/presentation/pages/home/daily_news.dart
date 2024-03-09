import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_learn/features/daily_news/domain/entities/article_entity.dart';
import 'package:riverpod_learn/features/daily_news/presentation/bloc/article/remote/bloc/remote_article_bloc.dart';
import 'package:riverpod_learn/features/daily_news/presentation/widgets/article_tile.dart';
import 'package:riverpod_learn/config/routes/nane_route.dart' as appRoutes;

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Daily News',
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        IconButton(
            onPressed: () => _onSavedArticlesTapped(context),
            icon: const Icon(
              Icons.bookmarks,
              color: Colors.black,
            ))
      ],
    );
  }

  _buildBody() {
    return BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
      builder: (_, state) {
        if (state is RemoteArticlesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is RemoteArticlesDone) {
          return ListView.builder(
              itemCount: state.data!.length,
              itemBuilder: (context, index) => ArticleWidget(
                    article: state.data![index],
                    onArticlePressed: (article) =>
                        _onArticleTapped(context, article),
                  ));
        }
        if (state is RemoteArticlesError) {
          return Center(
            child:
                IconButton(onPressed: () {}, icon: const Icon(Icons.refresh)),
          );
        }
        return const SizedBox();
      },
    );
  }

  _onArticleTapped(BuildContext context, ArticleEntity article) {
    context.pushNamed(appRoutes.dialyNewsDetails, extra: article);
  }

  _onSavedArticlesTapped(BuildContext context) {
    context.pushNamed(appRoutes.dialyNewsSaved);
  }
}
