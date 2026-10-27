import 'package:entrecomunidad/core/constants/app_constants.dart';
import 'package:entrecomunidad/core/theme/app_colors.dart';
import 'package:entrecomunidad/features/encomiendas/domain/encomienda.dart';
import 'package:flutter/material.dart';

class EncomiendaCard extends StatelessWidget {
  const EncomiendaCard({
    super.key,
    required this.encomienda,
    required this.onTap,
  });

  final Encomienda encomienda;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final estadoColor = _estadoColor(encomienda.estado);
    final foto = encomienda.fotos.isEmpty ? null : encomienda.fotos.first;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.blanco,
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.spacing16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _EstadoChip(label: encomienda.estadoLabel, color: estadoColor),
                    const Spacer(),
                    Text(
                      encomienda.pagoFormateado,
                      style: textTheme.titleMedium?.copyWith(
                        color: AppColors.verdeAmazonia,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        encomienda.descripcion,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyMedium?.copyWith(height: 1.4),
                      ),
                    ),
                    if (foto != null) ...[
                      const SizedBox(width: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                        child: Image.network(
                          foto,
                          width: 64,
                          height: 64,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 12),
                _RouteLine(
                  origen: encomienda.ubicacionOrigen,
                  destino: encomienda.ubicacionDestino,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(
                      Icons.photo_library_outlined,
                      size: 16,
                      color: AppColors.textoSecundario,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${encomienda.fotoCount} foto${encomienda.fotoCount == 1 ? '' : 's'}',
                      style: textTheme.labelSmall?.copyWith(
                        color: AppColors.textoSecundario,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Icon(
                      Icons.person_outline,
                      size: 16,
                      color: AppColors.textoSecundario,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        encomienda.publicador,
                        style: textTheme.labelSmall?.copyWith(
                          color: AppColors.textoSecundario,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EstadoChip extends StatelessWidget {
  const _EstadoChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

Color _estadoColor(EncomiendaEstado estado) {
  return switch (estado) {
    EncomiendaEstado.cancelada => AppColors.rojoInstitucional,
    EncomiendaEstado.enCamino || EncomiendaEstado.aceptada => AppColors.azulSistemas,
    _ => AppColors.verdeAmazonia,
  };
}

class _RouteLine extends StatelessWidget {
  const _RouteLine({required this.origen, required this.destino});

  final String origen;
  final String destino;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodySmall?.copyWith(
          color: AppColors.textoSecundario,
        );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.route_rounded, size: 18, color: AppColors.azulSistemas),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(origen, style: style),
              if (destino.isNotEmpty)
                Text(
                  '→ $destino',
                  style: style?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.texto,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
