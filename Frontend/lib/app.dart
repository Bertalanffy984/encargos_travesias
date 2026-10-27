import 'package:entrecomunidad/core/theme/app_theme.dart';
import 'package:entrecomunidad/features/encomiendas/data/encargos_store.dart';
import 'package:entrecomunidad/features/splash/presentation/splash_screen.dart';
import 'package:flutter/material.dart';

class EntreComunidadApp extends StatefulWidget {
  const EntreComunidadApp({super.key});

  @override
  State<EntreComunidadApp> createState() => _EntreComunidadAppState();
}

class _EntreComunidadAppState extends State<EntreComunidadApp> {
  final _store = EncargosStore();

  @override
  void dispose() {
    _store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EncargosScope(
      store: _store,
      child: MaterialApp(
        title: 'Travecias',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        home: const SplashScreen(),
      ),
    );
  }
}
