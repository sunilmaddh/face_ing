import 'package:flutter/material.dart';
import 'app_context.dart';

class AppSnackbar {
  static DateTime? _lastShownTime;
  static const int _debounceMs = 500;

  static void show({
    required String message,
    bool isError = false,
    required String title,
  }) {
    final now = DateTime.now();

    if (_lastShownTime != null &&
        now.difference(_lastShownTime!).inMilliseconds < _debounceMs) {
      return;
    }

    _lastShownTime = now;

    final messenger = AppContext.scaffoldMessengerKey.currentState;

    if (messenger == null) return;

    messenger.clearSnackBars();

    messenger.showSnackBar(
      SnackBar(
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(10),
        content: Row(
          children: [
            Icon(
              isError ? Icons.error : Icons.check_circle,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(message, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
