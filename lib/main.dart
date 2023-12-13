import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multiquization/game.dart';

import 'home.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final _router = GoRouter(
    routes: [
      GoRoute(path: "/", builder: (context, state) => const Home()),
      GoRoute(path: "/game", builder: (context, state) => Game(level: state.extra as int)),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
