import 'package:entrecomunidad/core/constants/app_constants.dart';
import 'package:entrecomunidad/core/theme/app_colors.dart';
import 'package:entrecomunidad/shared/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';

/// Publicación estilo feed social (Social-Mate / Venmo feed).
class FeedPost extends StatelessWidget {
  const FeedPost({
    super.key,
    required this.author,
    required this.community,
    required this.time,
    required this.content,
    required this.initials,
    this.likes = 0,
    this.comments = 0,
    this.hasMedia = false,
  });

  final String author;
  final String community;
  final String time;
  final String content;
  final String initials;
  final int likes;
  final int comments;
  final bool hasMedia;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ColoredBox(
      color: AppColors.blanco,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppConstants.spacing16,
          AppConstants.spacing16,
          AppConstants.spacing8,
          AppConstants.spacing12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ProfileAvatar(initials: initials, radius: 22),
                const SizedBox(width: AppConstants.spacing12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(author, style: textTheme.titleSmall),
                      Text(
                        '$community · $time',
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz_rounded),
                  color: AppColors.textoSecundario,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 54,
                top: AppConstants.spacing8,
                right: AppConstants.spacing8,
              ),
              child: Text(
                content,
                style: textTheme.bodyLarge?.copyWith(height: 1.5),
              ),
            ),
            if (hasMedia) ...[
              const SizedBox(height: AppConstants.spacing12),
              Padding(
                padding: const EdgeInsets.only(left: 54, right: AppConstants.spacing8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.verdeAmazonia.withValues(alpha: 0.25),
                            AppColors.azulSistemas.withValues(alpha: 0.2),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.landscape_rounded,
                          size: 48,
                          color: AppColors.blanco.withValues(alpha: 0.9),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
            Padding(
              padding: const EdgeInsets.only(left: 42, top: 4),
              child: Row(
                children: [
                  _IconStat(
                    icon: Icons.favorite_border_rounded,
                    count: likes,
                    onTap: () {},
                  ),
                  _IconStat(
                    icon: Icons.chat_bubble_outline_rounded,
                    count: comments,
                    onTap: () {},
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.share_outlined),
                    color: AppColors.textoSecundario,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IconStat extends StatelessWidget {
  const _IconStat({
    required this.icon,
    required this.count,
    required this.onTap,
  });

  final IconData icon;
  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Icon(icon, size: 22, color: AppColors.textoSecundario),
            if (count > 0) ...[
              const SizedBox(width: 4),
              Text(
                '$count',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.textoSecundario,
                    ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
