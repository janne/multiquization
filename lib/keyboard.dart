import 'package:flutter/material.dart';

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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(onPressed: () => _handlePress(1), child: Text("1", style: Theme.of(context).textTheme.headlineMedium)),
            ElevatedButton(onPressed: () => _handlePress(2), child: Text("2", style: Theme.of(context).textTheme.headlineMedium)),
            ElevatedButton(onPressed: () => _handlePress(3), child: Text("3", style: Theme.of(context).textTheme.headlineMedium)),
            ElevatedButton(onPressed: () => _handlePress(4), child: Text("4", style: Theme.of(context).textTheme.headlineMedium)),
            ElevatedButton(onPressed: () => _handlePress(5), child: Text("5", style: Theme.of(context).textTheme.headlineMedium)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(onPressed: () => _handlePress(6), child: Text("6", style: Theme.of(context).textTheme.headlineMedium)),
            ElevatedButton(onPressed: () => _handlePress(7), child: Text("7", style: Theme.of(context).textTheme.headlineMedium)),
            ElevatedButton(onPressed: () => _handlePress(8), child: Text("8", style: Theme.of(context).textTheme.headlineMedium)),
            ElevatedButton(onPressed: () => _handlePress(9), child: Text("9", style: Theme.of(context).textTheme.headlineMedium)),
            ElevatedButton(onPressed: () => _handlePress(0), child: Text("0", style: Theme.of(context).textTheme.headlineMedium)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32),
          child: ElevatedButton(onPressed: () => _handleBackspace(), child: Text("⌫", style: Theme.of(context).textTheme.headlineMedium)),
        ),
      ],
    );
  }
}
