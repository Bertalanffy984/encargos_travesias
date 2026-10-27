import 'package:entrecomunidad/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class FeedSearchField extends StatelessWidget {
  const FeedSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      onTap: () {},
      decoration: InputDecoration(
        hintText: 'Buscar personas, comunidades o publicaciones',
        prefixIcon: const Icon(Icons.search, size: 22),
        filled: true,
        fillColor: AppColors.blanco,
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(
            color: AppColors.textoSecundario.withValues(alpha: 0.25),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: AppColors.verdeAmazonia),
        ),
      ),
    );
  }
}
