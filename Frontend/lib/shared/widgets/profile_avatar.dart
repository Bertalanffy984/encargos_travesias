import 'package:entrecomunidad/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    this.imageUrl,
    this.radius = 28,
    this.initials,
  });

  final String? imageUrl;
  final double radius;
  final String? initials;

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: NetworkImage(imageUrl!),
        onBackgroundImageError: (_, __) {},
        child: null,
      );
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.verdeAmazonia.withValues(alpha: 0.15),
      foregroundColor: AppColors.verdeAmazonia,
      child: Text(
        initials ?? '?',
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
