import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int? lastScore;
  int? highScore;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          lastScore != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: Text("Senaste spelet: $lastScore", style: const TextStyle(fontSize: 24))),
                )
              : Container(),
          highScore != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: Text("Bäst hitills: $highScore", style: const TextStyle(fontSize: 24))),
                )
              : Container(),
          Center(
            child: IconButton(
              iconSize: 64,
              color: Colors.blue,
              onPressed: () async {
                final score = await context.push<int>("/game");
                setState(() {
                  if (score != null) {
                    lastScore = score;
                    highScore = highScore == null || score > highScore! ? score : highScore;
                  }
                });
              },
              icon: const Icon(Icons.play_circle_fill),
            ),
          )
        ],
      ),
    );
  }
}
