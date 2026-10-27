import 'package:entrecomunidad/core/constants/app_constants.dart';
import 'package:entrecomunidad/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Accesos rápidos tipo categorías (inspirado en rails de tienda / catálogo).
class CategoryShortcuts extends StatelessWidget {
  const CategoryShortcuts({super.key});

  static const _items = [
    _Shortcut('Comunidades', Icons.groups_rounded, AppColors.verdeAmazonia),
    _Shortcut('Eventos', Icons.event_rounded, AppColors.azulSistemas),
    _Shortcut('Recursos', Icons.folder_open_rounded, AppColors.rojoInstitucional),
    _Shortcut('Mapa', Icons.map_rounded, AppColors.verdeAmazonia),
    _Shortcut('Ayuda', Icons.help_outline_rounded, AppColors.azulSistemas),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 88,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacing16),
        itemCount: _items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final item = _items[index];
          return _ShortcutTile(item: item);
        },
      ),
    );
  }
}

class _Shortcut {
  const _Shortcut(this.label, this.icon, this.color);

  final String label;
  final IconData icon;
  final Color color;
}

class _ShortcutTile extends StatelessWidget {
  const _ShortcutTile({required this.item});

  final _Shortcut item;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.blanco,
      borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        child: SizedBox(
          width: 76,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(item.icon, color: item.color, size: 26),
              const SizedBox(height: 6),
              Text(
                item.label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
