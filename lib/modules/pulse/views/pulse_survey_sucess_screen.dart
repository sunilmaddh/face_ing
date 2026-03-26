import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/modules/pulse/controller/pulse_survey_controller.dart';
import 'package:ntt_data/modules/pulse/views/pulse_screen.dart';

class PulseSurveySuccessScreen extends StatefulWidget {
  const PulseSurveySuccessScreen({super.key});

  @override
  State<PulseSurveySuccessScreen> createState() =>
      _PulseSurveySuccessScreenState();
}

class _PulseSurveySuccessScreenState extends State<PulseSurveySuccessScreen> {
  Timer? _timer;
  late final PulseSurveyController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<PulseSurveyController>();

    _timer = Timer(const Duration(seconds: 3), () {
      if (!mounted) return;

      _controller.isNavigating = true;

      Get.off(() => PulseScreen(fromHome: false))?.whenComplete(() {
        _controller.isNavigating = false;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.isNavigating = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [Color(0xFFE3F2FD), Color(0xFFFFFFFF)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: const BoxDecoration(
                color: Color(0xFF0D8BDA),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 55),
            ),
            const SizedBox(height: 20),
            const Text(
              "All done!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D8BDA),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Analyzing your pulse survey",
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 25),
            const SizedBox(
              width: 28,
              height: 28,
              child: CupertinoActivityIndicator(radius: 12),
            ),
          ],
        ),
      ),
    );
  }
}
