import 'package:entrecomunidad/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Marca Travecias (wordmark). Los PNG oficiales se pueden volver a cablear
/// cuando existan en `assets/images/`.
class BrandMark extends StatelessWidget {
  const BrandMark({
    super.key,
    this.height = 32,
    this.compact = false,
  });

  final double height;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    if (compact) {
      return Text(
        'TV',
        style: textTheme.titleMedium?.copyWith(
          color: AppColors.verdeAmazonia,
          fontWeight: FontWeight.w700,
          height: 1,
          fontSize: height * 0.55,
        ),
      );
    }

    return Text(
      'Travecias',
      style: textTheme.titleLarge?.copyWith(
        color: AppColors.verdeAmazonia,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.3,
        height: 1,
        fontSize: height * 0.7,
      ),
    );
  }
}
