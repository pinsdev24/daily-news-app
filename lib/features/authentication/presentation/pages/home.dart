import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_learn/config/routes/nane_route.dart' as appRoutes;

import '../bloc/authentication/auth_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is LoggedOutState) {
                context.pushNamed(appRoutes.login);
              }
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: const Text('Home page'),
                actions: [
                  TextButton(
                    child: const Text('Log out',
                        style: TextStyle(color: Colors.red)),
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context).add(LogOutEvent());
                    },
                  )
                ],
              ),
              body: const Center(
                child: Image(
                  image: AssetImage('assets/home_page_background.gif'),
                ),
              ),
            )));
  }
}
