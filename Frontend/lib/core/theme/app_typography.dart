import 'package:entrecomunidad/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Montserrat: títulos y encabezados. Roboto: cuerpo, botones y etiquetas.
abstract final class AppTypography {
  static TextTheme textTheme(TextTheme base) {
    final montserrat = GoogleFonts.montserratTextTheme(base);
    final roboto = GoogleFonts.robotoTextTheme(base);

    return base.copyWith(
      displayLarge: montserrat.displayLarge?.copyWith(
        fontWeight: FontWeight.w700,
        color: AppColors.texto,
      ),
      displayMedium: montserrat.displayMedium?.copyWith(
        fontWeight: FontWeight.w700,
        color: AppColors.texto,
      ),
      displaySmall: montserrat.displaySmall?.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.texto,
      ),
      headlineLarge: montserrat.headlineLarge?.copyWith(
        fontWeight: FontWeight.w700,
        color: AppColors.texto,
      ),
      headlineMedium: montserrat.headlineMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.texto,
      ),
      headlineSmall: montserrat.headlineSmall?.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.texto,
      ),
      titleLarge: montserrat.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.texto,
      ),
      titleMedium: montserrat.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.texto,
      ),
      titleSmall: montserrat.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.texto,
      ),
      bodyLarge: roboto.bodyLarge?.copyWith(
        fontWeight: FontWeight.w400,
        color: AppColors.texto,
      ),
      bodyMedium: roboto.bodyMedium?.copyWith(
        fontWeight: FontWeight.w400,
        color: AppColors.texto,
      ),
      bodySmall: roboto.bodySmall?.copyWith(
        fontWeight: FontWeight.w400,
        color: AppColors.textoSecundario,
      ),
      labelLarge: roboto.labelLarge?.copyWith(
        fontWeight: FontWeight.w500,
        color: AppColors.texto,
      ),
      labelMedium: roboto.labelMedium?.copyWith(
        fontWeight: FontWeight.w500,
        color: AppColors.texto,
      ),
      labelSmall: roboto.labelSmall?.copyWith(
        fontWeight: FontWeight.w500,
        color: AppColors.textoSecundario,
      ),
    );
  }
}
