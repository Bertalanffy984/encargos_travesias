import 'package:entrecomunidad/core/constants/asset_paths.dart';
import 'package:entrecomunidad/core/theme/app_colors.dart';
import 'package:entrecomunidad/shared/widgets/institutional_logo.dart';
import 'package:flutter/material.dart';

/// AppBar con identidad EntreComunidad + institucional (logos visibles).
class EntreComunidadAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EntreComunidadAppBar({
    super.key,
    this.title,
    this.actions,
  });

  final String? title;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          const InstitutionalLogo(
            assetPath: AssetPaths.logoEntrecomunidad,
            semanticLabel: 'Logo EntreComunidad',
            height: 36,
          ),
          if (title != null) ...[
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title!,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ],
      ),
      actions: [
        ...?actions,
        const Padding(
          padding: EdgeInsets.only(right: 8),
          child: InstitutionalLogo(
            assetPath: AssetPaths.logoRedesComunitarias,
            semanticLabel: 'Logo Redes Comunitarias',
            height: 32,
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(3),
        child: Container(
          height: 3,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.verdeAmazonia,
                AppColors.azulSistemas,
                AppColors.rojoInstitucional,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
