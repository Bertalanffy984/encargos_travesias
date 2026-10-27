import 'package:entrecomunidad/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CommunityStoriesRow extends StatelessWidget {
  const CommunityStoriesRow({super.key, required this.items});

  final List<CommunityStoryItem> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 92,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = items[index];
          return _StoryBubble(item: item);
        },
      ),
    );
  }
}

class CommunityStoryItem {
  const CommunityStoryItem({
    required this.name,
    required this.initials,
    required this.color,
    this.isAdd = false,
  });

  final String name;
  final String initials;
  final Color color;
  final bool isAdd;
}

class _StoryBubble extends StatelessWidget {
  const _StoryBubble({required this.item});

  final CommunityStoryItem item;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: 72,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: item.isAdd
                  ? null
                  : const LinearGradient(
                      colors: [
                        AppColors.verdeAmazonia,
                        AppColors.azulSistemas,
                      ],
                    ),
              border: item.isAdd
                  ? Border.all(
                      color: AppColors.textoSecundario.withValues(alpha: 0.35),
                    )
                  : null,
            ),
            child: CircleAvatar(
              radius: 28,
              backgroundColor: item.isAdd
                  ? AppColors.fondo
                  : item.color.withValues(alpha: 0.15),
              foregroundColor: item.color,
              child: item.isAdd
                  ? const Icon(Icons.add, color: AppColors.verdeAmazonia)
                  : Text(item.initials, style: textTheme.titleSmall),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            item.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}
