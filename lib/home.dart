import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int? lastGame;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          lastGame != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: Text("Senaste spelet: $lastGame", style: const TextStyle(fontSize: 24))),
                )
              : Container(),
          Center(
            child: IconButton(
              iconSize: 64,
              color: Colors.blue,
              onPressed: () {
                context.push("/game");
              },
              icon: const Icon(Icons.play_circle_fill),
            ),
          )
        ],
      ),
    );
  }
}
