import 'package:entrecomunidad/core/constants/app_constants.dart';
import 'package:entrecomunidad/core/theme/app_colors.dart';
import 'package:entrecomunidad/core/theme/institutional_palette.dart';
import 'package:entrecomunidad/features/encomiendas/data/encargos_store.dart';
import 'package:entrecomunidad/features/encomiendas/domain/actividad_aviso.dart';
import 'package:flutter/material.dart';

/// Avisos tomados del historial de estados del backend.
class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = EncargosScope.of(context);
    final items = store.actividad;

    return ColoredBox(
      color: InstitutionalPalette.pageBackground,
      child: RefreshIndicator(
        color: AppColors.verdeAmazonia,
        onRefresh: () => store.refresh(silencioso: true),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(top: 20),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Actividad',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Historial de estados de los encargos en la base.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textoSecundario,
                        ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 16),
                    height: 3,
                    width: 40,
                    color: InstitutionalPalette.accentLine,
                  ),
                  if (store.error != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        store.error!,
                        style: const TextStyle(color: AppColors.rojoInstitucional),
                      ),
                    ),
                ],
              ),
            ),
            if (store.cargando && items.isEmpty)
              const Padding(
                padding: EdgeInsets.all(32),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (items.isEmpty)
              Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Todavía no hay movimientos',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textoSecundario,
                      ),
                ),
              )
            else
              ...items.map(
                (item) => Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: Material(
                    color: InstitutionalPalette.card,
                    borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: _color(item).withValues(alpha: 0.12),
                        child: Icon(_icon(item), color: _color(item), size: 20),
                      ),
                      title: Text(
                        item.titulo,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(item.subtitulo),
                      isThreeLine: true,
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 88),
          ],
        ),
      ),
    );
  }

  IconData _icon(ActividadAviso item) {
    return switch (item.estado.toLowerCase()) {
      'aceptado' => Icons.check_circle_outline,
      'en camino' => Icons.local_shipping_outlined,
      'entregado' => Icons.inventory_2_outlined,
      'cancelado' => Icons.cancel_outlined,
      _ => Icons.add_box_outlined,
    };
  }

  Color _color(ActividadAviso item) {
    return switch (item.estado.toLowerCase()) {
      'cancelado' => AppColors.rojoInstitucional,
      'en camino' || 'entregado' => AppColors.azulSistemas,
      _ => AppColors.verdeAmazonia,
    };
  }
}
