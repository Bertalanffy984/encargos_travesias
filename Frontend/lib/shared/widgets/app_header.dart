import 'package:entrecomunidad/core/constants/app_constants.dart';
import 'package:entrecomunidad/core/theme/app_colors.dart';
import 'package:entrecomunidad/shared/widgets/brand_mark.dart';
import 'package:entrecomunidad/shared/widgets/promo_top_strip.dart';
import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
    this.title,
    this.showBrand = false,
    this.breadcrumbs,
    this.showSearch = true,
  });

  final String? title;
  final bool showBrand;
  final List<String>? breadcrumbs;
  final bool showSearch;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const PromoTopStrip(),
        Material(
          elevation: 1,
          shadowColor: AppColors.texto.withValues(alpha: 0.08),
          color: AppColors.blanco,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppConstants.spacing16,
              AppConstants.spacing12,
              AppConstants.spacing8,
              AppConstants.spacing12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: showBrand
                          ? const BrandMark(height: 26)
                          : Text(
                              title ?? '',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                    ),
                    IconButton(
                      tooltip: 'Mensajes',
                      onPressed: () {},
                      icon: const Icon(Icons.chat_bubble_outline_rounded),
                    ),
                    IconButton(
                      tooltip: 'Notificaciones',
                      onPressed: () {},
                      icon: Badge(
                        smallSize: 8,
                        child: Icon(
                          Icons.notifications_none_rounded,
                          color: AppColors.texto.withValues(alpha: 0.9),
                        ),
                      ),
                    ),
                  ],
                ),
                if (showSearch) ...[
                  const SizedBox(height: AppConstants.spacing12),
                  TextField(
                    readOnly: true,
                    onTap: () {},
                    decoration: const InputDecoration(
                      hintText: 'Buscar comunidades, personas o publicaciones',
                      prefixIcon: Icon(Icons.search_rounded, size: 22),
                      isDense: true,
                    ),
                  ),
                ],
                if (breadcrumbs != null && breadcrumbs!.isNotEmpty) ...[
                  const SizedBox(height: AppConstants.spacing12),
                  _BreadcrumbTrail(items: breadcrumbs!),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _BreadcrumbTrail extends StatelessWidget {
  const _BreadcrumbTrail({required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodySmall;
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 4,
      children: [
        for (var i = 0; i < items.length; i++) ...[
          if (i > 0)
            const Icon(
              Icons.chevron_right_rounded,
              size: 16,
              color: AppColors.textoSecundario,
            ),
          Text(
            items[i],
            style: style?.copyWith(
              color: i == items.length - 1
                  ? AppColors.verdeAmazonia
                  : AppColors.textoSecundario,
              fontWeight:
                  i == items.length - 1 ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ],
    );
  }
}
