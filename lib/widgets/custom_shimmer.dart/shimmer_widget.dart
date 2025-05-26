import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ShimmerLoadingScreen extends StatelessWidget {
  const ShimmerLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shimmer Animation')),
      body: ListView.builder(
        itemCount: 8,
        itemBuilder: (context, index) {
          return const ShimmerListItem();
        },
      ),
    );
  }
}

class ShimmerListItem extends StatelessWidget {
  const ShimmerListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer(
            duration: const Duration(seconds: 2),
            interval: const Duration(seconds: 0),
            color: Colors.white,
            colorOpacity: 0.3,
            enabled: true,
            direction: const ShimmerDirection.fromLTRB(),
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer(
                  duration: const Duration(seconds: 2),
                  child: Container(
                    height: 16,
                    color: Colors.grey[300],
                    margin: const EdgeInsets.only(bottom: 8),
                  ),
                ),
                Shimmer(
                  duration: const Duration(seconds: 2),
                  child: Container(
                    height: 14,
                    width: 150,
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
