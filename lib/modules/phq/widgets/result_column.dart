import 'package:flutter/material.dart';

class ResultColumn extends StatelessWidget {
  final IconData icon;
  final String label;
  final String result;
  final Color resultColor;
  final String text1;
  final String text2;

  const ResultColumn({
    super.key,
    required this.icon,
    required this.label,
    required this.result,
    required this.resultColor,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ignore: deprecated_member_use
        Icon(icon, color: Colors.grey.withOpacity(0.7), size: 32),
        const SizedBox(height: 8),
        Text(
          label,
          // ignore: deprecated_member_use
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
        Text(
          text1,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          text2,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
