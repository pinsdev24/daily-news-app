import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_learn/core/constants/constants.dart';
import 'package:riverpod_learn/features/daily_news/domain/entities/article_entity.dart';
import 'package:riverpod_learn/features/daily_news/presentation/bloc/article/local/bloc/local_article_bloc.dart';

class ArticleDetailView extends StatelessWidget {
  final ArticleEntity? article;

  const ArticleDetailView({Key? key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _builAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildArticleTitleAndDates(),
              _buildArticleImage(),
              _buildArticleDescriptionAndContent()
            ],
          ),
        ),
      ),
      floatingActionButton: _buildFloatingSavedButton(context),
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
    );
  }

  Widget _buildArticleTitleAndDates() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        children: [
          Text(
            article!.title!,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 14,
          ),
          Row(
            children: [
              const Icon(
                Icons.timeline_outlined,
                size: 16,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                article!.publishedAt ?? '',
                style: const TextStyle(fontSize: 12),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildArticleImage() {
    return Container(
      width: double.maxFinite,
      height: 256,
      margin: const EdgeInsets.only(top: 14),
      child: Image.network(
        article!.urlToImage ?? kDefaultImage,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildArticleDescriptionAndContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          if (article!.description != null) ...[
            Text(
              article!.description!,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
          if (article!.content != null)
            Text(
              article!.content ?? '',
              style: const TextStyle(fontSize: 15),
            ),
        ],
      ),
    );
  }

  Widget _buildFloatingSavedButton(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'savedButton',
      onPressed: () => _onFloatingActionButtonPressed(context),
      backgroundColor: Colors.blue,
      child: const Icon(
        Icons.bookmark,
        color: Colors.white,
      ),
    );
  }

  _onFloatingActionButtonPressed(BuildContext context) {
    BlocProvider.of<LocalArticleBloc>(context).add(SaveArticle(article!));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        'Article saved succesfully',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.black,
    ));
  }

  _onBackButtonPressed(BuildContext context) {
    context.pop();
  }
}
