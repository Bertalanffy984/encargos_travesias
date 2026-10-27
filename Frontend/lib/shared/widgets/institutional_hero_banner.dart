import 'package:entrecomunidad/core/theme/app_colors.dart';
import 'package:entrecomunidad/core/theme/app_decorations.dart';
import 'package:entrecomunidad/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Patrón tipo dashboard (referencia: apps M3 con hero + métricas).
class InstitutionalHeroBanner extends StatelessWidget {
  const InstitutionalHeroBanner({
    super.key,
    required this.greeting,
    required this.headline,
    this.subtitle,
  });

  final String greeting;
  final String headline;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: AppDecorations.heroBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.verdeAmazonia.withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            greeting,
            style: textTheme.labelLarge?.copyWith(
              color: AppColors.azulSistemas,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            headline,
            style: textTheme.headlineSmall?.copyWith(
              color: AppColors.verdeAmazonia,
              height: 1.2,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              subtitle!,
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.textoSecundario,
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: const SizedBox(
              height: 4,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: AppDecorations.institutionalStrip,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
