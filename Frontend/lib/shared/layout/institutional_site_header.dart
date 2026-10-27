import 'package:entrecomunidad/core/constants/asset_paths.dart';
import 'package:entrecomunidad/core/theme/institutional_palette.dart';
import 'package:entrecomunidad/shared/widgets/institutional_logo.dart';
import 'package:flutter/material.dart';

class InstitutionalSiteHeader extends StatelessWidget {
  const InstitutionalSiteHeader({
    super.key,
    required this.sectionTitle,
    required this.selectedIndex,
    required this.onSelect,
    required this.onMenu,
    required this.onSearch,
  });

  final String sectionTitle;
  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final VoidCallback onMenu;
  final VoidCallback onSearch;

  static const _labels = ['Inicio', 'Explorar', 'Actividad', 'Perfil'];

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      shadowColor: Colors.black.withValues(alpha: 0.14),
      color: InstitutionalPalette.headerBackground,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 3,
            child: ColoredBox(color: InstitutionalPalette.accentLine),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final wide = constraints.maxWidth >= 720;
                return wide
                    ? _DesktopHeader(
                        selectedIndex: selectedIndex,
                        onSelect: onSelect,
                        onSearch: onSearch,
                      )
                    : _MobileHeader(
                        sectionTitle: sectionTitle,
                        onMenu: onMenu,
                        onSearch: onSearch,
                      );
              },
            ),
          ),
          if (MediaQuery.sizeOf(context).width >= 720)
            const SizedBox(height: 4)
          else
            const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _DesktopHeader extends StatelessWidget {
  const _DesktopHeader({
    required this.selectedIndex,
    required this.onSelect,
    required this.onSearch,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final VoidCallback onSearch;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Row(
        children: [
          const InstitutionalLogo(
            assetPath: AssetPaths.logoEntrecomunidad,
            semanticLabel: 'EntreComunidad',
            height: 40,
            monogram: 'E',
            onDarkBackground: true,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(InstitutionalSiteHeader._labels.length, (i) {
                return _NavTab(
                  label: InstitutionalSiteHeader._labels[i],
                  selected: selectedIndex == i,
                  onTap: () => onSelect(i),
                );
              }),
            ),
          ),
          IconButton(
            onPressed: onSearch,
            icon: const Icon(Icons.search, color: Colors.white),
            tooltip: 'Buscar',
          ),
        ],
      ),
    );
  }
}

class _MobileHeader extends StatelessWidget {
  const _MobileHeader({
    required this.sectionTitle,
    required this.onMenu,
    required this.onSearch,
  });

  final String sectionTitle;
  final VoidCallback onMenu;
  final VoidCallback onSearch;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: Row(
        children: [
          const InstitutionalLogo(
            assetPath: AssetPaths.logoEntrecomunidad,
            semanticLabel: 'EntreComunidad',
            height: 36,
            monogram: 'E',
            onDarkBackground: true,
          ),
          Expanded(
            child: Text(
              sectionTitle,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          IconButton(
            onPressed: onSearch,
            icon: const Icon(Icons.search, color: Colors.white),
          ),
          TextButton.icon(
            onPressed: onMenu,
            icon: const Icon(Icons.menu, color: Colors.white, size: 22),
            label: const Text('Menú', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class _NavTab extends StatelessWidget {
  const _NavTab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withValues(alpha: selected ? 1 : 0.92),
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              height: 3,
              width: selected ? 36 : 0,
              decoration: BoxDecoration(
                color: selected
                    ? InstitutionalPalette.navUnderline
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
