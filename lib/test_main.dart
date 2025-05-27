import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Progress Bar',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ProgressBarScreen(),
    );
  }
}

class ProgressBarScreen extends StatefulWidget {
  @override
  _ProgressBarScreenState createState() => _ProgressBarScreenState();
}

class _ProgressBarScreenState extends State<ProgressBarScreen> {
  int _progress = 0;
  Timer? _timer;
  final int totalSeconds = 60;

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_progress >= 100) {
        _timer?.cancel();
      } else {
        setState(() {
          _progress += (100 ~/ totalSeconds);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FA Progress Bar')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text(
              //   '$_progress%',
              //   style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              // ),
              // SizedBox(height: 24),
              FAProgressBar(
                currentValue: _progress.toDouble(),
                displayText: '%',
                size: 20,
                maxValue: 100,
                animatedDuration: Duration(milliseconds: 300),
                progressColor: Colors.green,
                backgroundColor: Colors.grey.shade300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
