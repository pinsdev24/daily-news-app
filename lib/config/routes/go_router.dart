import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_learn/config/routes/nane_route.dart';
import 'package:riverpod_learn/features/authentication/presentation/bloc/authentication/auth_bloc.dart';
import 'package:riverpod_learn/features/authentication/presentation/pages/auth/sign_in_page.dart';
import 'package:riverpod_learn/features/authentication/presentation/pages/auth/sign_up_page.dart';
import 'package:riverpod_learn/features/authentication/presentation/pages/auth/verify_email.dart';
import 'package:riverpod_learn/features/daily_news/domain/entities/article_entity.dart';
import 'package:riverpod_learn/features/daily_news/presentation/bloc/article/local/bloc/local_article_bloc.dart';
import 'package:riverpod_learn/features/daily_news/presentation/bloc/article/remote/bloc/remote_article_bloc.dart';
import 'package:riverpod_learn/features/daily_news/presentation/pages/article_detail/article_detail.dart';
import 'package:riverpod_learn/features/daily_news/presentation/pages/home/daily_news.dart';
import 'package:riverpod_learn/features/daily_news/presentation/pages/saved_article/saved_article.dart';
import 'package:riverpod_learn/injection_container.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  routes: [
    /* GoRoute(
      path: '/',
      name: dialyNews,
      builder: (context, state) => BlocProvider<AuthBloc>(
        create: (context) => sl()..add(CheckLoggingInEvent()),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authSstate) {
            if (authSstate is SignedInPageState) {
              return BlocProvider<RemoteArticleBloc>(
                create: (context) => sl()..add(const GetArticles()),
                child: DailyNews(
                  key: state.pageKey,
                ),
              );
            } else {
              return SignIn(
                key: state.pageKey,
              );
            }
          },
        ),
      ),
    ), */
    GoRoute(
        path: '/',
        name: dialyNews,
        builder: (context, state) => BlocProvider<RemoteArticleBloc>(
              create: (context) => sl()..add(const GetArticles()),
              child: DailyNews(
                key: state.pageKey,
              ),
            )),
    GoRoute(
        path: '/ArticleDetails',
        name: dialyNewsDetails,
        builder: (context, state) {
          ArticleEntity? article = state.extra as ArticleEntity;
          return BlocProvider<LocalArticleBloc>(
            create: (context) => sl<LocalArticleBloc>(),
            child: ArticleDetailView(key: state.pageKey, article: article),
          );
        }),
    GoRoute(
      path: '/SavedArticles',
      name: dialyNewsSaved,
      builder: (context, state) => BlocProvider<LocalArticleBloc>(
        create: (context) => sl()..add(const GetSavedArticles()),
        child: SavedArticles(
          key: state.pageKey,
        ),
      ),
    ),
    GoRoute(
        path: '/login',
        name: login,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => SignIn(
              key: state.pageKey,
            ),
        routes: [
          GoRoute(
            path: 'register',
            name: register,
            builder: (context, state) => BlocProvider<AuthBloc>(
              create: (context) => sl(),
              child: SignUp(
                key: state.pageKey,
              ),
            ),
          ),
        ]),
    GoRoute(
      path: '/verifyEmail',
      name: veryEmail,
      builder: (context, state) => BlocProvider<AuthBloc>(
        create: (context) => sl(),
        child: VerifyEmail(
          key: state.pageKey,
        ),
      ),
    ),
  ],
);
