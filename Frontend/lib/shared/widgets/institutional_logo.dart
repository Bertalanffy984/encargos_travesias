import 'package:entrecomunidad/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Monograma institucional. Cuando tengas los PNG oficiales en
/// `assets/images/`, se puede volver a usar [Image.asset].
class InstitutionalLogo extends StatelessWidget {
  const InstitutionalLogo({
    super.key,
    required this.assetPath,
    required this.semanticLabel,
    this.height = 40,
    this.monogram,
    this.onDarkBackground = false,
  });

  final String assetPath;
  final String semanticLabel;
  final double height;
  final String? monogram;
  final bool onDarkBackground;

  @override
  Widget build(BuildContext context) {
    final letter = monogram ??
        (semanticLabel.isNotEmpty ? semanticLabel[0].toUpperCase() : '?');
    final fg = onDarkBackground ? AppColors.blanco : AppColors.verdeAmazonia;

    return Semantics(
      label: semanticLabel,
      child: Container(
        height: height,
        width: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: onDarkBackground
              ? AppColors.blanco.withValues(alpha: 0.15)
              : AppColors.verdeAmazonia.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Text(
          letter,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: fg,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );
  }
}
