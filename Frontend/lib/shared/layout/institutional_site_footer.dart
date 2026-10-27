import 'package:entrecomunidad/core/constants/asset_paths.dart';
import 'package:entrecomunidad/core/theme/institutional_palette.dart';
import 'package:entrecomunidad/shared/widgets/brand_mark.dart';
import 'package:entrecomunidad/shared/widgets/institutional_logo.dart';
import 'package:flutter/material.dart';

/// Pie al estilo [SiteFooter](file:///pagina_Institucion) — columnas y gradiente.
class InstitutionalSiteFooter extends StatelessWidget {
  const InstitutionalSiteFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final year = DateTime.now().year;

    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            InstitutionalPalette.footerBackground,
            InstitutionalPalette.footerBackgroundLower,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 32, 20, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(child: BrandMark(height: 32)),
            const SizedBox(height: 12),
            Center(
              child: Text(
                'EntreComunidad · Redes Comunitarias',
                textAlign: TextAlign.center,
                style: textTheme.titleSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Center(
              child: Text(
                'Universidad de la Amazonia · Ingeniería de Sistemas',
                textAlign: TextAlign.center,
                style: textTheme.bodySmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.75),
                ),
              ),
            ),
            const SizedBox(height: 28),
            const _FooterColumn(
              title: 'Comunidad',
              links: [
                'Preguntas frecuentes',
                'Contacto',
                'Reportar contenido',
              ],
            ),
            const SizedBox(height: 20),
            const _FooterColumn(
              title: 'Proyecto',
              links: [
                'Acerca de EntreComunidad',
                'Términos de uso',
                'Privacidad',
              ],
            ),
            const SizedBox(height: 20),
            const _FooterColumn(
              title: 'Contacto',
              links: [
                'servicio@redescomunitarias.edu.co',
                'Florencia, Caquetá',
              ],
            ),
            const SizedBox(height: 24),
            const Wrap(
              spacing: 16,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                InstitutionalLogo(
                  assetPath: AssetPaths.logoUniversidad,
                  semanticLabel: 'Universidad de la Amazonia',
                  height: 36,
                  monogram: 'U',
                ),
                InstitutionalLogo(
                  assetPath: AssetPaths.logoSistemas,
                  semanticLabel: 'Ingeniería de Sistemas',
                  height: 36,
                  monogram: 'S',
                ),
                InstitutionalLogo(
                  assetPath: AssetPaths.logoRedesComunitarias,
                  semanticLabel: 'Redes Comunitarias',
                  height: 36,
                  monogram: 'R',
                ),
              ],
            ),
            const SizedBox(height: 20),
            Divider(color: Colors.white.withValues(alpha: 0.15)),
            const SizedBox(height: 12),
            Text(
              '© $year EntreComunidad. Todos los derechos reservados.',
              style: textTheme.labelSmall?.copyWith(
                color: Colors.white.withValues(alpha: 0.55),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FooterColumn extends StatelessWidget {
  const _FooterColumn({required this.title, required this.links});

  final String title;
  final List<String> links;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
        ),
        const SizedBox(height: 8),
        ...links.map(
          (link) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              link,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white.withValues(alpha: 0.35),
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
