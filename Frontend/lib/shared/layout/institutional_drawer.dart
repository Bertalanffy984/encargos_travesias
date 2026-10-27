import 'package:entrecomunidad/core/theme/app_colors.dart';
import 'package:entrecomunidad/core/theme/institutional_palette.dart';
import 'package:flutter/material.dart';

class InstitutionalDrawer extends StatelessWidget {
  const InstitutionalDrawer({
    super.key,
    required this.selectedIndex,
    required this.onSelect,
    required this.onPublish,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final VoidCallback onPublish;

  static const _items = [
    (Icons.home_outlined, 'Inicio'),
    (Icons.explore_outlined, 'Explorar comunidades'),
    (Icons.notifications_outlined, 'Actividad'),
    (Icons.person_outline, 'Perfil'),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              color: InstitutionalPalette.headerBackground,
              child: Text(
                'Menú principal',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final (icon, label) = _items[index];
                  final selected = selectedIndex == index;
                  return ListTile(
                    leading: Icon(
                      icon,
                      color: selected
                          ? AppColors.verdeAmazonia
                          : AppColors.texto,
                    ),
                    title: Text(
                      label,
                      style: TextStyle(
                        fontWeight:
                            selected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                    selected: selected,
                    onTap: () {
                      Navigator.pop(context);
                      onSelect(index);
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  onPublish();
                },
                icon: const Icon(Icons.edit_outlined),
                label: const Text('Publicar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
