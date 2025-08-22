import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ntt_data/modules/views/vital_graph/vital_graph_history.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VitalGraphHistory(),
    );
  }
}
