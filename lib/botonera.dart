import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String value;
  final Color color;
  final Function(String) onPressed;

  const CalculatorButton({
    required this.value,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        color: color,
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white24,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: InkWell(
          onTap: () => onPressed(value),
          child: Center(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
