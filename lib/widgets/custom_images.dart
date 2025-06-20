import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomImage extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final BoxFit fit;
  final bool isNetwork;

  const CustomImage({
    Key? key,
    required this.path,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.isNetwork = false,
  }) : super(key: key);

  bool get _isSvg => path.toLowerCase().endsWith('.svg');

  @override
  Widget build(BuildContext context) {
    if (isNetwork) {
      return _isSvg ? _buildSvgNetwork() : _buildRasterNetwork();
    } else {
      return _isSvg ? _buildSvgAsset() : _buildRasterAsset();
    }
  }

  Widget _buildSvgNetwork() {
    return SvgPicture.network(
      path,
      width: width,
      height: height,
      fit: fit,
      placeholderBuilder: (context) => _placeholder(),
    );
  }

  Widget _buildRasterNetwork() {
    return CachedNetworkImage(
      imageUrl: path,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => _placeholder(),
      errorWidget: (context, url, error) => _errorIcon(),
    );
  }

  Widget _buildSvgAsset() {
    return SvgPicture.asset(
      path,
      width: width,
      height: height,
      fit: fit,
    );
  }

  Widget _buildRasterAsset() {
    return Image.asset(
      path,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) => _errorIcon(),
    );
  }

  Widget _placeholder() => const Center(
    child: SizedBox(
      width: 24,
      height: 24,
      child: CircularProgressIndicator(strokeWidth: 2),
    ),
  );

  Widget _errorIcon() => const Icon(Icons.broken_image, size: 40, color: Colors.grey);
}
