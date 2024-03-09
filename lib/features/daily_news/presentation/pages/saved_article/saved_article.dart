import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_learn/features/daily_news/domain/entities/article_entity.dart';
import 'package:riverpod_learn/features/daily_news/presentation/bloc/article/local/bloc/local_article_bloc.dart';
import 'package:riverpod_learn/features/daily_news/presentation/widgets/article_tile.dart';
import 'package:riverpod_learn/config/routes/nane_route.dart' as appRoutes;

class SavedArticles extends StatelessWidget {
  const SavedArticles({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _builAppBar(),
      body: _buildBody(),
    );
  }

  _builAppBar() {
    return AppBar(
      centerTitle: true,
      leading: Builder(
        builder: (context) => GestureDetector(
          onTap: () => _onBackButtonPressed(context),
          behavior: HitTestBehavior.opaque,
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      title:
          const Text("Saved articles", style: TextStyle(color: Colors.black)),
    );
  }

  _onBackButtonPressed(BuildContext context) {
    context.pop();
  }

  Widget _buildBody() {
    return BlocBuilder<LocalArticleBloc, LocalArticleState>(
        builder: (context, state) {
      if (state is LocalArticlesLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is LocalArticlesDone) {
        return _buildSavedArticlesList(state.articles!);
      }
      return Container();
    });
  }

  _buildSavedArticlesList(List<ArticleEntity> articles) {
    if (articles.isEmpty) {
      return const Center(
        child: Text('No Saved Articles'),
      );
    } else {
      return ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) => ArticleWidget(
                article: articles[index],
                onArticlePressed: (article) =>
                    _onArticleTapped(context, article),
                onArticleRemoved: (article) =>
                    _onArticleRemoved(context, article),
              ));
    }
  }

  _onArticleTapped(BuildContext context, ArticleEntity article) {
    context.pushNamed(appRoutes.dialyNewsDetails, extra: article);
  }

  _onArticleRemoved(BuildContext context, ArticleEntity article) {
    BlocProvider.of<LocalArticleBloc>(context).add(RemoveArticle(article));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        'Article Removed succesfully',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.black,
    ));
  }
}
