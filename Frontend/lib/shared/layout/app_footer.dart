import 'package:entrecomunidad/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Pie al final del scroll (solo cierre legal, sin logos).
class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final year = DateTime.now().year;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 16),
      child: Column(
        children: [
          Divider(color: AppColors.textoSecundario.withValues(alpha: 0.2)),
          const SizedBox(height: 16),
          Text(
            'Proyecto Redes Comunitarias · EntreComunidad',
            textAlign: TextAlign.center,
            style: textTheme.labelMedium?.copyWith(
              color: AppColors.verdeAmazonia,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '© $year EntreComunidad. Todos los derechos reservados.',
            textAlign: TextAlign.center,
            style: textTheme.labelSmall?.copyWith(
              color: AppColors.textoSecundario,
            ),
          ),
        ],
      ),
    );
  }
}
