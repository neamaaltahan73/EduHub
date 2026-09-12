import 'package:flutter/material.dart';
import '../colors/app_colors.dart';

class AppNetworkImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;

  const AppNetworkImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return _placeholder();
    }
    return Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return _placeholder(showSpinner: true);
      },
      errorBuilder: (context, error, stackTrace) => _placeholder(),
    );
  }

  Widget _placeholder({bool showSpinner = false}) {
    return Container(
      width: width,
      height: height,
      color: AppColors.divider,
      alignment: Alignment.center,
      child: showSpinner
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.image_outlined, color: AppColors.textGrey),
    );
  }
}
