import 'dart:async';
import 'dart:math';

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
  var multiplier = 0;
  var multiplicand = 0;
  var score = 0;
  int? previousGuess;
  final random = Random();

  @override
  void initState() {
    super.initState();
    _randomize();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final duration = DateTime.now().difference(startTime);
      _updateTime(duration);
      if (duration > const Duration(seconds: 61)) {
        context.pop(score);
      }
    });
  }

  _randomize() {
    setState(() {
      multiplier = random.nextInt(10);
      multiplicand = random.nextInt(10);
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

  void _onGuess(int? guess) {
    final product = multiplier * multiplicand;
    if (guess == product) {
      _randomize();
      setState(() {
        score += 1;
        previousGuess = null;
      });
    } else if (guess == null || product.toString().indexOf(guess.toString()) == 0) {
      setState(() => previousGuess = guess);
    } else {
      _randomize();
      setState(() {
        score -= 1;
        previousGuess = null;
      });
    }
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
            Text("Score: $score", style: Theme.of(context).textTheme.headlineSmall),
            Text("$multiplier ✖ $multiplicand", style: Theme.of(context).textTheme.displayMedium),
            Keyboard(guess: previousGuess, onPress: _onGuess)
          ],
        ),
      ),
    );
  }
}
