import 'package:entrecomunidad/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Barra inferior con botón central (patrón Social-Mate).
class SocialBottomBar extends StatelessWidget {
  const SocialBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onCreate,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.blanco,
        boxShadow: [
          BoxShadow(
            color: AppColors.texto.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavIcon(
                index: 0,
                current: currentIndex,
                icon: Icons.home_rounded,
                outline: Icons.home_outlined,
                onTap: onTap,
              ),
              _NavIcon(
                index: 1,
                current: currentIndex,
                icon: Icons.explore_rounded,
                outline: Icons.explore_outlined,
                onTap: onTap,
              ),
              _CreateFab(onPressed: onCreate),
              _NavIcon(
                index: 2,
                current: currentIndex,
                icon: Icons.notifications_rounded,
                outline: Icons.notifications_none_rounded,
                onTap: onTap,
              ),
              _NavIcon(
                index: 3,
                current: currentIndex,
                icon: Icons.person_rounded,
                outline: Icons.person_outline_rounded,
                onTap: onTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  const _NavIcon({
    required this.index,
    required this.current,
    required this.icon,
    required this.outline,
    required this.onTap,
  });

  final int index;
  final int current;
  final IconData icon;
  final IconData outline;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final selected = current == index;
    return IconButton(
      onPressed: () => onTap(index),
      icon: Icon(
        selected ? icon : outline,
        size: 26,
        color: selected ? AppColors.verdeAmazonia : AppColors.textoSecundario,
      ),
    );
  }
}

class _CreateFab extends StatelessWidget {
  const _CreateFab({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      shadowColor: AppColors.verdeAmazonia.withValues(alpha: 0.35),
      color: AppColors.verdeAmazonia,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: const SizedBox(
          width: 52,
          height: 52,
          child: Icon(Icons.add_rounded, color: AppColors.blanco, size: 28),
        ),
      ),
    );
  }
}
