import 'package:entrecomunidad/core/constants/app_constants.dart';
import 'package:entrecomunidad/core/theme/app_colors.dart';
import 'package:entrecomunidad/core/theme/institutional_palette.dart';
import 'package:flutter/material.dart';

class CommunitiesScreen extends StatelessWidget {
  const CommunitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: InstitutionalPalette.pageBackground,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Explorar comunidades',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 12),
                  const _SearchPlaceholder(),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 88),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.78,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => _CommunityGridCard(item: _items[index]),
                childCount: _items.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CommunityGridCard extends StatelessWidget {
  const _CommunityGridCard({required this.item});

  final _CommunityItem item;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: InstitutionalPalette.card,
      borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ColoredBox(
                color: item.color.withValues(alpha: 0.85),
                child: Center(
                  child: Text(
                    item.initials,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 36,
                    child: FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        padding: EdgeInsets.zero,
                        textStyle: const TextStyle(fontSize: 13),
                      ),
                      child: const Text('Unirme'),
                    ),
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

class _CommunityItem {
  const _CommunityItem({
    required this.name,
    required this.initials,
    required this.color,
  });

  final String name;
  final String initials;
  final Color color;
}

class _SearchPlaceholder extends StatelessWidget {
  const _SearchPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        hintText: 'Buscar comunidades',
        prefixIcon: Icon(Icons.search_rounded),
      ),
    );
  }
}

const _items = [
  _CommunityItem(
    name: 'Red Caquetá Rural',
    initials: 'RC',
    color: AppColors.verdeAmazonia,
  ),
  _CommunityItem(
    name: 'Emprendimiento Amazónico',
    initials: 'EA',
    color: AppColors.azulSistemas,
  ),
  _CommunityItem(
    name: 'Educación Comunitaria',
    initials: 'EC',
    color: AppColors.rojoInstitucional,
  ),
  _CommunityItem(
    name: 'Conectividad Sur',
    initials: 'CS',
    color: AppColors.verdeAmazonia,
  ),
];
