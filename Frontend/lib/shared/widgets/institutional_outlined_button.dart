import 'package:entrecomunidad/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

enum InstitutionalOutlineColor { verde, rojo }

class InstitutionalOutlinedButton extends StatelessWidget {
  const InstitutionalOutlinedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color = InstitutionalOutlineColor.verde,
  });

  final String label;
  final VoidCallback? onPressed;
  final InstitutionalOutlineColor color;

  @override
  Widget build(BuildContext context) {
    final borderColor = color == InstitutionalOutlineColor.verde
        ? AppColors.verdeAmazonia
        : AppColors.rojoInstitucional;

    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: borderColor,
        side: BorderSide(color: borderColor, width: 1.5),
      ),
      child: Text(label),
    );
  }
}
