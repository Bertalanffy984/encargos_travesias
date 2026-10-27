import 'package:entrecomunidad/core/constants/app_constants.dart';
import 'package:entrecomunidad/core/constants/asset_paths.dart';
import 'package:entrecomunidad/core/theme/app_colors.dart';
import 'package:entrecomunidad/shared/widgets/institutional_logo.dart';
import 'package:flutter/material.dart';

/// Pie de página institucional (estructura tipo footer e-commerce profesional).
class InstitutionalFooter extends StatelessWidget {
  const InstitutionalFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ColoredBox(
      color: AppColors.texto,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 28, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'EntreComunidad',
              style: textTheme.titleMedium?.copyWith(
                color: AppColors.blanco,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Conectando territorios · Proyecto Redes Comunitarias',
              style: textTheme.bodySmall?.copyWith(
                color: AppColors.blanco.withValues(alpha: 0.75),
              ),
            ),
            const SizedBox(height: 24),
            const _FooterSection(
              title: 'Atención a la comunidad',
              links: [
                'Preguntas frecuentes',
                'Contacto del proyecto',
                'Reportar un problema',
              ],
            ),
            const SizedBox(height: 20),
            const _FooterSection(
              title: 'Proyecto',
              links: [
                'Acerca de Redes Comunitarias',
                'Términos de uso',
                'Privacidad y datos',
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Identidad institucional',
              style: textTheme.labelLarge?.copyWith(color: AppColors.blanco),
            ),
            const SizedBox(height: 12),
            const Wrap(
              spacing: 16,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                InstitutionalLogo(
                  assetPath: AssetPaths.logoUniversidad,
                  semanticLabel: 'Universidad de la Amazonia',
                  height: 40,
                  monogram: 'U',
                ),
                InstitutionalLogo(
                  assetPath: AssetPaths.logoSistemas,
                  semanticLabel: 'Ingeniería de Sistemas',
                  height: 40,
                  monogram: 'S',
                ),
                InstitutionalLogo(
                  assetPath: AssetPaths.logoRedesComunitarias,
                  semanticLabel: 'Redes Comunitarias',
                  height: 40,
                  monogram: 'R',
                ),
                InstitutionalLogo(
                  assetPath: AssetPaths.logoEntrecomunidad,
                  semanticLabel: 'EntreComunidad',
                  height: 40,
                  monogram: 'E',
                ),
              ],
            ),
            const SizedBox(height: 24),
            Divider(color: AppColors.blanco.withValues(alpha: 0.15)),
            const SizedBox(height: 16),
            Text(
              'Universidad de la Amazonia · Ingeniería de Sistemas',
              style: textTheme.bodySmall?.copyWith(
                color: AppColors.blanco.withValues(alpha: 0.65),
              ),
            ),
            Text(
              '© ${DateTime.now().year} EntreComunidad. Todos los derechos reservados.',
              style: textTheme.labelSmall?.copyWith(
                color: AppColors.blanco.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FooterSection extends StatelessWidget {
  const _FooterSection({required this.title, required this.links});

  final String title;
  final List<String> links;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.titleSmall?.copyWith(
            color: AppColors.blanco,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        ...links.map(
          (link) => Padding(
            padding: const EdgeInsets.only(bottom: AppConstants.spacing8),
            child: InkWell(
              onTap: () {},
              child: Text(
                link,
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.blanco.withValues(alpha: 0.8),
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.blanco.withValues(alpha: 0.35),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
