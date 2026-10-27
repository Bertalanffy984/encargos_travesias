import 'package:entrecomunidad/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ContentImage extends StatelessWidget {
  const ContentImage({
    super.key,
    required this.image,
    this.height = 180,
    this.width,
  });

  final ImageProvider image;
  final double height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image(
        image: image,
        height: height,
        width: width,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          height: height,
          width: width,
          color: AppColors.fondo,
          alignment: Alignment.center,
          child: Text(
            'Imagen no disponible',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ),
    );
  }
}
