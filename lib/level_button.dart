import 'package:flutter/material.dart';

class LevelButton extends StatelessWidget {
  final Color color;
  final String label;
  final void Function()? onPressed;

  const LevelButton({super.key, required this.color, this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Row(children: [
        Icon(Icons.play_circle_fill, size: 64, color: color),
        Text(label, style: Theme.of(context).textTheme.headlineMedium),
      ]),
    );
  }
}
