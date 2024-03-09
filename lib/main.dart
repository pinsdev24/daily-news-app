import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riverpod_learn/config/routes/go_router.dart';
import 'package:riverpod_learn/config/themes/app_themes.dart';
import 'package:riverpod_learn/features/daily_news/presentation/bloc/article/remote/bloc/remote_article_bloc.dart';
import 'package:riverpod_learn/firebase_options.dart';
import 'package:riverpod_learn/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteArticleBloc>(
        create: (context) => sl()..add(const GetArticles()),
        child: MaterialApp.router(
          title: 'Flutter Clean Architecture',
          debugShowCheckedModeBanner: false,
          theme: theme(),
          routerDelegate: goRouter.routerDelegate,
          routeInformationParser: goRouter.routeInformationParser,
          routeInformationProvider: goRouter.routeInformationProvider,
        ));
  }
}
