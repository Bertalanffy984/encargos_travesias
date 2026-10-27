import 'package:entrecomunidad/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Franja superior informativa (patrón e-commerce / [WeShop](https://www.weshop.com.co)).
class PromoTopStrip extends StatelessWidget {
  const PromoTopStrip({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.verdeAmazonia,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          'Redes Comunitarias · Universidad de la Amazonia · Ingeniería de Sistemas',
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.blanco,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}
