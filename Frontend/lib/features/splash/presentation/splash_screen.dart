import 'dart:async';

import 'package:entrecomunidad/core/constants/asset_paths.dart';
import 'package:entrecomunidad/core/theme/app_colors.dart';
import 'package:entrecomunidad/core/theme/app_decorations.dart';
import 'package:entrecomunidad/features/shell/presentation/main_shell.dart';
import 'package:entrecomunidad/shared/widgets/brand_mark.dart';
import 'package:entrecomunidad/shared/widgets/institutional_logo.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Timer _navigationTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
    _navigationTimer = Timer(const Duration(milliseconds: 2400), _goHome);
  }

  @override
  void dispose() {
    _navigationTimer.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _goHome() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder<void>(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, __, ___) => const MainShell(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(gradient: AppDecorations.heroBackground),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fade,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                children: [
                  const Spacer(flex: 3),
                  const BrandMark(height: 56),
                  const SizedBox(height: 12),
                  Text(
                    'Travecias',
                    style: textTheme.titleMedium?.copyWith(
                      color: AppColors.azulSistemas,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Encomiendas · Redes Comunitarias · Uniamazonia',
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.textoSecundario,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(flex: 3),
                  const Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 20,
                    runSpacing: 12,
                    children: [
                      InstitutionalLogo(
                        assetPath: AssetPaths.logoUniversidad,
                        semanticLabel: 'Universidad de la Amazonia',
                        height: 44,
                        monogram: 'U',
                      ),
                      InstitutionalLogo(
                        assetPath: AssetPaths.logoSistemas,
                        semanticLabel: 'Ingeniería de Sistemas',
                        height: 44,
                        monogram: 'S',
                      ),
                      InstitutionalLogo(
                        assetPath: AssetPaths.logoRedesComunitarias,
                        semanticLabel: 'Redes Comunitarias',
                        height: 44,
                        monogram: 'R',
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.verdeAmazonia,
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
