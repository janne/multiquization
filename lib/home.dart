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

  void _startGame(int level) async {
    final score = await context.push<int>("/game", extra: level);
    if (score != null) {
      setState(() {
        lastScore = score;
        highScore = highScore == null || score > highScore! ? score : highScore;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Multiquization")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (highScore != null || lastScore != null)
            Column(children: [
              if (lastScore != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: Text("Last game: $lastScore", style: const TextStyle(fontSize: 24))),
                ),
              if (highScore != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: Text("High score: $highScore", style: const TextStyle(fontSize: 24))),
                )
            ]),
          Column(
            children: [
              LevelButton(onPressed: () => _startGame(1), color: Colors.blue[100]!, label: 'Level 1'),
              LevelButton(onPressed: () => _startGame(2), color: Colors.blue, label: 'Level 2'),
              LevelButton(onPressed: () => _startGame(3), color: Colors.blue[900]!, label: 'Level 3'),
            ],
          ),
        ],
      ),
    );
  }
}
