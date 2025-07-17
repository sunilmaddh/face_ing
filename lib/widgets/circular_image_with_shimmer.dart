import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CircularImageWithShimmer extends StatelessWidget {
  final String imageUrl;
  final double size;

  const CircularImageWithShimmer({
    Key? key,
    required this.imageUrl,
    this.size = 59.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: size,
        height: size,
        fit: BoxFit.cover,
        placeholder:
            (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(width: size, height: size, color: Colors.white),
            ),
        errorWidget:
            (context, url, error) => Container(
              width: size,
              height: size,
              color: Colors.grey,
              child: const Icon(Icons.error, color: Colors.white),
            ),
      ),
    );
  }
}
