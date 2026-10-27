import 'package:entrecomunidad/core/theme/app_colors.dart';
import 'package:entrecomunidad/core/theme/app_spacing.dart';
import 'package:entrecomunidad/shared/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';

class CommunityPostCard extends StatelessWidget {
  const CommunityPostCard({
    super.key,
    required this.authorName,
    required this.communityName,
    required this.timeAgo,
    required this.body,
    required this.initials,
    this.likes = 0,
    this.comments = 0,
    this.showImage = false,
  });

  final String authorName;
  final String communityName;
  final String timeAgo;
  final String body;
  final String initials;
  final int likes;
  final int comments;
  final bool showImage;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.blanco,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.textoSecundario.withValues(alpha: 0.12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 4, 0),
            child: Row(
              children: [
                ProfileAvatar(initials: initials, radius: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(authorName, style: textTheme.titleSmall),
                      Text(
                        '$communityName · $timeAgo',
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz),
                  color: AppColors.textoSecundario,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
            child: Text(
              body,
              style: textTheme.bodyLarge?.copyWith(height: 1.45),
            ),
          ),
          if (showImage) ...[
            const SizedBox(height: 12),
            Container(
              height: 160,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  colors: [
                    AppColors.verdeAmazonia.withValues(alpha: 0.2),
                    AppColors.azulSistemas.withValues(alpha: 0.15),
                  ],
                ),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.photo_outlined,
                size: 40,
                color: AppColors.verdeAmazonia.withValues(alpha: 0.7),
              ),
            ),
          ],
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 4, 4, 8),
            child: Row(
              children: [
                _FeedAction(
                  icon: Icons.favorite_border,
                  label: '$likes',
                  onTap: () {},
                ),
                _FeedAction(
                  icon: Icons.mode_comment_outlined,
                  label: '$comments',
                  onTap: () {},
                ),
                _FeedAction(
                  icon: Icons.share_outlined,
                  label: 'Compartir',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeedAction extends StatelessWidget {
  const _FeedAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20, color: AppColors.textoSecundario),
              const SizedBox(width: 6),
              Text(
                label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.textoSecundario,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
