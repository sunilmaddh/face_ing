import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CommonAssets {
  /// Load a local SVG asset
  static Widget svgAsset(String assetName,
      {double? width, double? height, Color? color}) {
    return SvgPicture.asset(
      assetName,
      width: width,
      height: height,
      colorFilter: color != null
          ? ColorFilter.mode(color, BlendMode.srcIn)
          : null,
    );
  }

  /// Load a local image asset
  static Widget imageAsset(String assetName,
      {double? width, double? height, BoxFit fit = BoxFit.cover}) {
    return Image.asset(
      assetName,
      width: width,
      height: height,
      fit: fit,
    );
  }

  /// Load a network SVG image
  static Widget svgNetwork(String url,
      {double? width, double? height, Color? color}) {
    return SvgPicture.network(
      url,
      width: width,
      height: height,
      colorFilter: color != null
          ? ColorFilter.mode(color, BlendMode.srcIn)
          : null,
    );
  }

  /// Load a network image with caching
  static Widget networkImage(String url,
      {double? width,
      double? height,
      BoxFit fit = BoxFit.cover,
      Widget? placeholder,
      Widget? errorWidget}) {
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => placeholder ?? _defaultPlaceholder(),
      errorWidget: (context, url, error) => errorWidget ?? _defaultErrorWidget(),
    );
  }

  /// Set a background image (local or network)
  static Decoration backgroundImage(String image,
      {bool isNetwork = false, BoxFit fit = BoxFit.cover}) {
    return BoxDecoration(
      image: DecorationImage(
        image: isNetwork ? CachedNetworkImageProvider(image) : AssetImage(image) as ImageProvider,
        fit: fit,
      ),
    );
  }

  /// Default placeholder widget
  static Widget _defaultPlaceholder() {
    return const Center(child: CircularProgressIndicator());
  }

  /// Default error widget
  static Widget _defaultErrorWidget() {
    return const Center(child: Icon(Icons.error, color: Colors.red));
  }
}
