import 'package:entrecomunidad/core/theme/app_colors.dart';
import 'package:entrecomunidad/shared/widgets/brand_mark.dart';
import 'package:flutter/material.dart';

class HomeTopBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeTopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const BrandMark(height: 28),
      centerTitle: false,
      actions: [
        IconButton(
          tooltip: 'Buscar',
          onPressed: () {},
          icon: const Icon(Icons.search),
        ),
        IconButton(
          tooltip: 'Mensajes',
          onPressed: () {},
          icon: const Badge(
            label: Text('2'),
            child: Icon(Icons.chat_bubble_outline),
          ),
        ),
        const SizedBox(width: 4),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(2),
        child: Container(height: 2, color: AppColors.verdeAmazonia.withValues(alpha: 0.85)),
      ),
    );
  }
}
