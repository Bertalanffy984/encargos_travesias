import 'package:entrecomunidad/core/theme/app_colors.dart';
import 'package:entrecomunidad/core/theme/institutional_palette.dart';
import 'package:entrecomunidad/features/activity/presentation/activity_screen.dart';
import 'package:entrecomunidad/features/encomiendas/data/encargos_store.dart';
import 'package:entrecomunidad/features/encomiendas/presentation/create_encomienda_screen.dart';
import 'package:entrecomunidad/features/encomiendas/presentation/encomiendas_home_screen.dart';
import 'package:entrecomunidad/features/encomiendas/presentation/my_encomiendas_screen.dart';
import 'package:entrecomunidad/features/profile/presentation/profile_screen.dart';
import 'package:flutter/material.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;
  var _cargoEncargos = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_cargoEncargos) return;
    _cargoEncargos = true;
    EncargosScope.of(context).refresh();
  }

  static const _screens = <Widget>[
    EncomiendasHomeScreen(),
    MyEncomiendasScreen(),
    ActivityScreen(),
    ProfileScreen(),
  ];

  void _openCreate() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const CreateEncomiendaScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InstitutionalPalette.pageBackground,
      body: SafeArea(
        child: IndexedStack(
          index: _index,
          children: _screens,
        ),
      ),
      floatingActionButton: _index == 0
          ? FloatingActionButton.extended(
              onPressed: _openCreate,
              backgroundColor: AppColors.verdeAmazonia,
              foregroundColor: AppColors.blanco,
              icon: const Icon(Icons.add_box_outlined),
              label: const Text('Solicitar'),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.local_shipping_outlined),
            selectedIcon: Icon(Icons.local_shipping_rounded),
            label: 'Solicitudes',
          ),
          NavigationDestination(
            icon: Icon(Icons.inventory_2_outlined),
            selectedIcon: Icon(Icons.inventory_2_rounded),
            label: 'Mis envíos',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_outlined),
            selectedIcon: Icon(Icons.notifications_rounded),
            label: 'Actividad',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
