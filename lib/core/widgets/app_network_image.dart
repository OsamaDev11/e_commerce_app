import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:e_commerce_app/core/responsive/app_scale.dart';
import 'package:e_commerce_app/core/theming/app_colors.dart';
import 'package:e_commerce_app/core/theming/app_dimens.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => const _ImageStateIcon(
        icon: Icons.image_outlined,
      ),
      errorWidget: (context, url, error) => const _ImageStateIcon(
        icon: Icons.image_not_supported_outlined,
      ),
    );
  }
}

class _ImageStateIcon extends StatelessWidget {
  const _ImageStateIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        icon,
        size: AppScale.s(AppSizes.iconLg),
        color: AppColors.textSecondary,
      ),
    );
  }
}
