import 'package:entrecomunidad/core/theme/app_colors.dart';
import 'package:entrecomunidad/shared/widgets/app_header.dart';
import 'package:flutter/material.dart';

class SocialScaffold extends StatelessWidget {
  const SocialScaffold({
    super.key,
    required this.body,
    this.title,
    this.showBrand = false,
    this.breadcrumbs,
    this.showSearch = true,
  });

  final Widget body;
  final String? title;
  final bool showBrand;
  final List<String>? breadcrumbs;
  final bool showSearch;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.fondo,
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppHeader(
              title: title,
              showBrand: showBrand,
              breadcrumbs: breadcrumbs,
              showSearch: showSearch,
            ),
            Expanded(child: body),
          ],
        ),
      ),
    );
  }
}
