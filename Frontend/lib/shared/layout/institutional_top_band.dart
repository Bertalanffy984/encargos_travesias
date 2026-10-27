import 'package:entrecomunidad/core/constants/asset_paths.dart';
import 'package:entrecomunidad/core/theme/app_colors.dart';
import 'package:entrecomunidad/shared/widgets/institutional_logo.dart';
import 'package:flutter/material.dart';

/// Identidad institucional arriba (no pegada abajo).
class InstitutionalTopBand extends StatelessWidget {
  const InstitutionalTopBand({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: AppColors.blanco,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
        child: Column(
          children: [
            const Wrap(
              alignment: WrapAlignment.center,
              spacing: 16,
              runSpacing: 8,
              children: [
                InstitutionalLogo(
                  assetPath: AssetPaths.logoUniversidad,
                  semanticLabel: 'Universidad de la Amazonia',
                  height: 32,
                  monogram: 'U',
                ),
                InstitutionalLogo(
                  assetPath: AssetPaths.logoSistemas,
                  semanticLabel: 'Ingeniería de Sistemas',
                  height: 32,
                  monogram: 'S',
                ),
                InstitutionalLogo(
                  assetPath: AssetPaths.logoRedesComunitarias,
                  semanticLabel: 'Redes Comunitarias',
                  height: 32,
                  monogram: 'R',
                ),
                InstitutionalLogo(
                  assetPath: AssetPaths.logoEntrecomunidad,
                  semanticLabel: 'EntreComunidad',
                  height: 32,
                  monogram: 'E',
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              'Universidad de la Amazonia · Ingeniería de Sistemas · Redes Comunitarias',
              textAlign: TextAlign.center,
              style: textTheme.labelSmall?.copyWith(
                color: AppColors.textoSecundario,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
