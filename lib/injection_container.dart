import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:riverpod_learn/core/network/network_info.dart';
import 'package:riverpod_learn/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:riverpod_learn/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:riverpod_learn/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:riverpod_learn/features/authentication/domain/usecases/check_verification_usecase.dart';
import 'package:riverpod_learn/features/authentication/domain/usecases/first_page_usecase.dart';
import 'package:riverpod_learn/features/authentication/domain/usecases/google_auth_usecase.dart';
import 'package:riverpod_learn/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:riverpod_learn/features/authentication/domain/usecases/sign_in_usecase.dart';
import 'package:riverpod_learn/features/authentication/domain/usecases/sign_up_usecase.dart';
import 'package:riverpod_learn/features/authentication/domain/usecases/verifiy_email_usecase.dart';
import 'package:riverpod_learn/features/authentication/presentation/bloc/authentication/auth_bloc.dart';
import 'package:riverpod_learn/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:riverpod_learn/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:riverpod_learn/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:riverpod_learn/features/daily_news/domain/repository/article_repository.dart';
import 'package:riverpod_learn/features/daily_news/domain/usecaces/get_article.dart';
import 'package:riverpod_learn/features/daily_news/domain/usecaces/get_saved_article.dart';
import 'package:riverpod_learn/features/daily_news/domain/usecaces/remove_article.dart';
import 'package:riverpod_learn/features/daily_news/domain/usecaces/save_article.dart';
import 'package:riverpod_learn/features/daily_news/presentation/bloc/article/local/bloc/local_article_bloc.dart';
import 'package:riverpod_learn/features/daily_news/presentation/bloc/article/remote/bloc/remote_article_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database').build();

  sl.registerSingleton<AppDatabase>(database);

  // Dio
  sl.registerSingleton<Dio>(Dio());

  // News Api Service
  sl.registerSingleton(NewsApiService(sl()));

  // News Api Service
  sl.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(sl(), sl()));

  //Usecases

  sl.registerSingleton<GetArticleUseCase>(GetArticleUseCase(sl()));
  sl.registerSingleton<GetSavedArticleUseCase>(GetSavedArticleUseCase(sl()));
  sl.registerSingleton<SaveArticleUseCase>(SaveArticleUseCase(sl()));
  sl.registerSingleton<RemoveArticleUseCase>(RemoveArticleUseCase(sl()));

  // BLoc
  sl.registerFactory<RemoteArticleBloc>(() => RemoteArticleBloc(sl()));
  sl.registerFactory<LocalArticleBloc>(
      () => LocalArticleBloc(sl(), sl(), sl()));

  // Bloc

  sl.registerFactory(() => AuthBloc(
      signInUseCase: sl(),
      signUpUseCase: sl(),
      firstPage: sl(),
      verifyEmailUseCase: sl(),
      checkVerificationUseCase: sl(),
      logOutUseCase: sl(),
      googleAuthUseCase: sl()));

// Usecases

  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => FirstPageUseCase(sl()));
  sl.registerLazySingleton(() => VerifyEmailUseCase(sl()));
  sl.registerLazySingleton(() => CheckVerificationUseCase(sl()));
  sl.registerLazySingleton(() => LogOutUseCase(sl()));
  sl.registerLazySingleton(() => GoogleAuthUseCase(sl()));

// Repository

  sl.registerLazySingleton<AuthenticationRepository>(() =>
      AuthenticationRepositoryImp(
          networkInfo: sl(), authRemoteDataSource: sl()));

// Datasources

  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl());

//! Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//! External

  sl.registerLazySingleton(() => InternetConnection());
}
