import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_learn/core/constants/constants.dart';
import 'package:riverpod_learn/features/daily_news/domain/entities/article_entity.dart';

import 'package:cached_network_image/cached_network_image.dart';

class ArticleWidget extends StatelessWidget {
  final ArticleEntity article;
  final void Function(ArticleEntity article)? onArticlePressed;
  final void Function(ArticleEntity article)? onArticleRemoved;

  const ArticleWidget(
      {super.key,
      required this.article,
      this.onArticlePressed,
      this.onArticleRemoved});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _onTap,
      child: Container(
        padding:
            const EdgeInsetsDirectional.only(start: 14, end: 14, bottom: 14),
        height: MediaQuery.of(context).size.width / 2.2,
        child: Row(
          children: [
            _buildImage(),
            _buildTitleAndDescription(),
            _buildRemoveIcon()
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return CachedNetworkImage(
      imageUrl: article.urlToImage ?? kDefaultImage,
      imageBuilder: (context, imageProvider) => Padding(
        padding: const EdgeInsetsDirectional.only(end: 14),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.08),
                image:
                    DecorationImage(image: imageProvider, fit: BoxFit.cover)),
          ),
        ),
      ),
      progressIndicatorBuilder: (context, url, progress) => Padding(
          padding: const EdgeInsetsDirectional.only(end: 14),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              width: MediaQuery.of(context).size.width / 3,
              height: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.08),
              ),
              child: const CupertinoActivityIndicator(),
            ),
          )),
      errorWidget: (context, url, error) => Padding(
          padding: const EdgeInsetsDirectional.only(end: 14),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              width: MediaQuery.of(context).size.width / 3,
              height: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.08),
              ),
              child: const Icon(
                Icons.error,
                color: Colors.red,
              ),
            ),
          )),
    );
  }

  Widget _buildTitleAndDescription() {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article.title ?? '',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black87),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              article.description ?? '',
              maxLines: 2,
            ),
          )),
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
                article.publishedAt ?? '',
                style: const TextStyle(fontSize: 12),
              )
            ],
          )
        ],
      ),
    ));
  }

  Widget _buildRemoveIcon() {
    return onArticleRemoved != null
        ? IconButton(
            onPressed: () {
              if (onArticleRemoved != null) {
                onArticleRemoved!(article);
              }
            },
            icon: const Icon(
              Icons.remove_circle_outline,
              color: Colors.red,
            ))
        : Container();
  }

  void _onTap() {
    if (onArticlePressed != null) {
      onArticlePressed!(article);
    }
  }
}
