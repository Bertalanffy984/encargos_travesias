import 'package:entrecomunidad/core/theme/app_colors.dart';
import 'package:entrecomunidad/core/theme/app_decorations.dart';
import 'package:entrecomunidad/shared/widgets/brand_mark.dart';
import 'package:flutter/material.dart';

/// Encabezado claro — guía EntreComunidad (sin GOV.CO ni barra oscura).
class EntreComunidadHeader extends StatelessWidget implements PreferredSizeWidget {
  const EntreComunidadHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.blanco,
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 56,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    const SizedBox(width: 8),
                    const BrandMark(height: 28),
                    const Spacer(),
                    IconButton(
                      tooltip: 'Buscar',
                      onPressed: () {},
                      icon: Icon(
                        Icons.search_rounded,
                        color: AppColors.texto.withValues(alpha: 0.85),
                      ),
                    ),
                    IconButton(
                      tooltip: 'Notificaciones',
                      onPressed: () {},
                      icon: Badge(
                        smallSize: 8,
                        child: Icon(
                          Icons.notifications_none_rounded,
                          color: AppColors.texto.withValues(alpha: 0.85),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 3,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: AppDecorations.institutionalStrip,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
