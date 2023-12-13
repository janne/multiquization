import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multiquization/keyboard.dart';

class Game extends StatefulWidget {
  final int level;

  const Game({super.key, required this.level});

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
  final audioPlayer = AudioPlayer();
  final scoreSound = AssetSource("audio/score.mp3");
  final wrongSound = AssetSource("audio/wrong.mp3");

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
      switch (widget.level) {
        case 1:
          multiplier = random.nextInt(5);
          multiplicand = random.nextInt(5);
          break;
        case 2:
          multiplier = random.nextInt(11);
          multiplicand = random.nextInt(11);
          break;
        case 3:
          multiplier = random.nextInt(5) + 5;
          multiplicand = random.nextInt(5) + 5;
          break;
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

  void _onGuess(int? guess) {
    final product = multiplier * multiplicand;
    if (guess == product) {
      _randomize();
      setState(() {
        score += widget.level;
        previousGuess = null;
        audioPlayer.stop();
        audioPlayer.play(scoreSound);
      });
    } else if (guess == null || product.toString().indexOf(guess.toString()) == 0) {
      setState(() => previousGuess = guess);
    } else {
      setState(() {
        score -= widget.level;
        previousGuess = null;
        audioPlayer.stop();
        audioPlayer.play(wrongSound);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Level ${widget.level}")),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(time, style: Theme.of(context).textTheme.headlineSmall),
                  Text(score.toString(), style: Theme.of(context).textTheme.headlineSmall),
                ],
              ),
              Text("$multiplier ✖ $multiplicand", style: Theme.of(context).textTheme.displayMedium),
              Keyboard(guess: previousGuess, onPress: _onGuess)
            ],
          ),
        ),
      ),
    );
  }
}
