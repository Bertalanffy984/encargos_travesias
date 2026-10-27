import 'package:entrecomunidad/core/constants/app_constants.dart';
import 'package:entrecomunidad/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Rail de filtros (patrón Cronicle / discover).
class FilterRail extends StatelessWidget {
  const FilterRail({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacing16),
        itemCount: labels.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final selected = selectedIndex == index;
          return FilterChip(
            label: Text(labels[index]),
            selected: selected,
            onSelected: (_) => onSelected(index),
            showCheckmark: false,
            labelStyle: TextStyle(
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              color: selected ? AppColors.verdeAmazonia : AppColors.textoSecundario,
            ),
            backgroundColor: AppColors.blanco,
            selectedColor: AppColors.verdeAmazonia.withValues(alpha: 0.12),
            side: BorderSide(
              color: selected
                  ? AppColors.verdeAmazonia.withValues(alpha: 0.5)
                  : AppColors.textoSecundario.withValues(alpha: 0.2),
            ),
          );
        },
      ),
    );
  }
}
