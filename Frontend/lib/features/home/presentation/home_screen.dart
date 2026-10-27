import 'package:entrecomunidad/core/theme/app_colors.dart';
import 'package:entrecomunidad/core/theme/institutional_palette.dart';
import 'package:entrecomunidad/shared/widgets/community_stories_row.dart';
import 'package:entrecomunidad/shared/widgets/feed_post.dart';
import 'package:entrecomunidad/shared/widgets/filter_rail.dart';
import 'package:entrecomunidad/shared/widgets/post_composer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _filter = 0;
  static const _filters = ['Para ti', 'Siguiendo', 'Eventos', 'Cerca'];

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: InstitutionalPalette.pageBackground,
      child: RefreshIndicator(
        color: AppColors.verdeAmazonia,
        onRefresh: () async {
          await Future<void>.delayed(const Duration(milliseconds: 400));
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: PostComposer(),
              ),
            ),
            SliverToBoxAdapter(
              child: FilterRail(
                labels: _filters,
                selectedIndex: _filter,
                onSelected: (i) => setState(() => _filter = i),
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: CommunityStoriesRow(
                  items: [
                    CommunityStoryItem(
                      name: 'Unirte',
                      initials: '+',
                      color: AppColors.verdeAmazonia,
                      isAdd: true,
                    ),
                    CommunityStoryItem(
                      name: 'Caquetá',
                      initials: 'CR',
                      color: AppColors.verdeAmazonia,
                    ),
                    CommunityStoryItem(
                      name: 'Emprende',
                      initials: 'EA',
                      color: AppColors.azulSistemas,
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildListDelegate(const [
                  FeedPost(
                    author: 'María González',
                    community: 'Red Caquetá Rural',
                    time: '25 min',
                    content:
                        'Este sábado tenemos el encuentro de conectividad comunitaria '
                        'en el centro cultural.',
                    initials: 'MG',
                    likes: 24,
                    comments: 8,
                    hasMedia: true,
                  ),
                  SizedBox(height: 8),
                  FeedPost(
                    author: 'Carlos Restrepo',
                    community: 'Emprendimiento Amazónico',
                    time: '2 h',
                    content:
                        'Nueva guía sobre financiación colectiva para proyectos locales.',
                    initials: 'CR',
                    likes: 41,
                    comments: 5,
                  ),
                ]),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 88)),
          ],
        ),
      ),
    );
  }
}
