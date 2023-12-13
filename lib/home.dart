import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multiquization/level_button.dart';

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              LevelButton(
                onPressed: () async {
                  final score = await context.push<int>("/game", extra: 1);
                  setState(() {
                    if (score != null) {
                      lastScore = score;
                      highScore = highScore == null || score > highScore! ? score : highScore;
                    }
                  });
                },
                color: Colors.blue,
                label: 'Level 1',
              ),
              LevelButton(
                onPressed: () async {
                  final score = await context.push<int>("/game", extra: 2);
                  setState(() {
                    if (score != null) {
                      lastScore = score;
                      highScore = highScore == null || score > highScore! ? score : highScore;
                    }
                  });
                },
                color: Colors.red,
                label: 'Level 2',
              )
            ],
          ),
        ],
      ),
    );
  }
}
