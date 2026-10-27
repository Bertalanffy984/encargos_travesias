import 'package:entrecomunidad/core/theme/app_colors.dart';
import 'package:entrecomunidad/core/theme/institutional_palette.dart';
import 'package:flutter/material.dart';

/// Contenedor de página interna (equivalente a `PageLayout` + `PageHeading`).
class InstitutionalPageBody extends StatelessWidget {
  const InstitutionalPageBody({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: InstitutionalPalette.pageBackground,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.texto,
                ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 20),
            height: 3,
            width: 48,
            decoration: BoxDecoration(
              color: InstitutionalPalette.accentLine,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
