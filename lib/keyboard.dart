import 'package:flutter/material.dart';
import 'package:multiquization/number_button.dart';

class Keyboard extends StatelessWidget {
  final void Function(int? i) onPress;
  final int? guess;

  const Keyboard({super.key, required this.onPress, this.guess});

  _handlePress(int i) {
    if (guess != null) {
      onPress(guess! * 10 + i);
    } else {
      onPress(i);
    }
  }

  _handleBackspace() {
    if (guess != null) {
      onPress(guess! < 10 ? null : guess! ~/ 10);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("${guess ?? ''}", style: Theme.of(context).textTheme.headlineMedium),
        Row(
          children: [
            NumberButton(onPressed: _handlePress, number: 7),
            NumberButton(onPressed: _handlePress, number: 8),
            NumberButton(onPressed: _handlePress, number: 9),
          ],
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          NumberButton(onPressed: _handlePress, number: 4),
          NumberButton(onPressed: _handlePress, number: 5),
          NumberButton(onPressed: _handlePress, number: 6),
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NumberButton(onPressed: _handlePress, number: 1),
            NumberButton(onPressed: _handlePress, number: 2),
            NumberButton(onPressed: _handlePress, number: 3),
          ],
        ),
        Row(
          children: [
            NumberButton(onPressed: _handlePress, number: 0),
          ],
        )
      ],
    );
  }
}
