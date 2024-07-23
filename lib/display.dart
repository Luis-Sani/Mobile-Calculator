import 'package:flutter/material.dart';

class DisplayWidget extends StatelessWidget {
  final String displayText;

  const DisplayWidget({required this.displayText});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      padding: const EdgeInsets.all(16),
      child: Text(
        displayText.isEmpty ? "0" : displayText,
        style: const TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.end,
      ),
    );
  }
}
