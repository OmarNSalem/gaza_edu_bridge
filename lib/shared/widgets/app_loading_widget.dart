import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_border_radius.dart';

/// Shimmer loading widget — يُستخدم بدلاً من CircularProgressIndicator
class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({
    super.key,
    this.height = 120,
    this.width = double.infinity,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.surfaceAccent,
      highlightColor: AppColors.secondary,
      child: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          color: AppColors.card,
          borderRadius: AppBorderRadius.largeRadius,
        ),
      ),
    );
  }
}
