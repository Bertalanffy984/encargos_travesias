import 'package:entrecomunidad/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

abstract final class AppDecorations {
  static const LinearGradient institutionalStrip = LinearGradient(
    colors: [
      AppColors.verdeAmazonia,
      AppColors.azulSistemas,
      AppColors.rojoInstitucional,
    ],
  );

  static LinearGradient heroBackground = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.verdeAmazonia.withValues(alpha: 0.12),
      AppColors.azulSistemas.withValues(alpha: 0.08),
      AppColors.fondo,
    ],
  );

  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: AppColors.texto.withValues(alpha: 0.06),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];
}
