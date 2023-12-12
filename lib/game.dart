import 'dart:async';

import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  var time = "00:00";
  var startTime = DateTime.now();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), _updateTime);
  }

  void _updateTime(timer) => setState(() {
        final duration = DateTime.now().difference(startTime);
        final mins = duration.inMinutes.remainder(60).toString().padLeft(2, "0");
        final secs = duration.inSeconds.remainder(60).toString().padLeft(2, "0");
        time = "$mins:$secs";
      });

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text(time, style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
      ),
    );
  }
}
