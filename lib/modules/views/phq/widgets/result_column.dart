import 'package:flutter/material.dart';

class ResultColumn extends StatelessWidget {
  final IconData icon;
  final String label;
  final String result;
  final Color resultColor;

  const ResultColumn({
    super.key,
    required this.icon,
    required this.label,
    required this.result,
    required this.resultColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.grey.withOpacity(0.7), size: 32),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(color: Colors.black.withOpacity(0.9), fontSize: 11),
        ),
        const SizedBox(height: 4),
        Text(
          result,
          style: TextStyle(
            color: resultColor,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
