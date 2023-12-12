import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multiquization/keyboard.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  var time = "00:00";
  var startTime = DateTime.now();
  Timer? timer;
  var multiplier = 3;
  var multiplicand = 5;
  var score = 0;
  int? guess;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final duration = DateTime.now().difference(startTime);
      _updateTime(duration);
      if (duration > const Duration(seconds: 181)) {
        context.pop(score);
      }
    });
  }

  void _updateTime(Duration duration) => setState(() {
        final mins = duration.inMinutes.remainder(60).toString().padLeft(2, "0");
        final secs = duration.inSeconds.remainder(60).toString().padLeft(2, "0");
        time = "$mins:$secs";
      });

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _onGuess(int? i) {
    setState(() => guess = i);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(time, style: Theme.of(context).textTheme.headlineSmall),
            Text("$multiplier ✖ $multiplicand", style: Theme.of(context).textTheme.displayMedium),
            Keyboard(guess: guess, onPress: _onGuess)
          ],
        ),
      ),
    );
  }
}
