import 'package:entrecomunidad/core/config/api_config.dart';
import 'package:entrecomunidad/core/constants/app_constants.dart';
import 'package:entrecomunidad/core/theme/app_colors.dart';
import 'package:entrecomunidad/core/theme/institutional_palette.dart';
import 'package:entrecomunidad/features/encomiendas/data/encargos_api.dart';
import 'package:entrecomunidad/features/encomiendas/data/encargos_store.dart';
import 'package:entrecomunidad/features/encomiendas/domain/encomienda.dart';
import 'package:flutter/material.dart';

enum DetailMode { cumplidor, publicador }

class EncomiendaDetailScreen extends StatefulWidget {
  const EncomiendaDetailScreen({
    super.key,
    required this.encomienda,
    required this.mode,
  });

  final Encomienda encomienda;
  final DetailMode mode;

  @override
  State<EncomiendaDetailScreen> createState() => _EncomiendaDetailScreenState();
}

class _EncomiendaDetailScreenState extends State<EncomiendaDetailScreen> {
  var _ocupado = false;

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> _ejecutar(Future<void> Function() accion, String ok) async {
    if (_ocupado) return;
    setState(() => _ocupado = true);
    try {
      await accion();
      if (!mounted) return;
      _snack(ok);
      Navigator.of(context).pop();
    } on EncargosApiException catch (e) {
      if (!mounted) return;
      _snack(e.message);
    } catch (_) {
      if (!mounted) return;
      _snack('No se pudo conectar con el backend');
    } finally {
      if (mounted) setState(() => _ocupado = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final e = widget.encomienda;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: InstitutionalPalette.pageBackground,
      appBar: AppBar(
        title: const Text('Detalle de encomienda'),
        backgroundColor: AppColors.blanco,
        foregroundColor: AppColors.texto,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: _EstadoPill(encomienda: e),
          ),
          const SizedBox(height: 12),
          Text(e.descripcion,
              style: textTheme.bodyLarge?.copyWith(height: 1.45)),
          const SizedBox(height: 8),
          Text(e.pagoFormateado,
              style: textTheme.headlineSmall?.copyWith(
                color: AppColors.verdeAmazonia,
                fontWeight: FontWeight.w700,
              )),
          const SizedBox(height: 16),
          _InfoTile(
            icon: Icons.place_outlined,
            title: 'Origen',
            subtitle: e.ubicacionOrigen,
          ),
          if (e.ubicacionDestino.isNotEmpty)
            _InfoTile(
              icon: Icons.flag_outlined,
              title: 'Destino',
              subtitle: e.ubicacionDestino,
            ),
          _InfoTile(
            icon: Icons.person_outline,
            title: 'Publicó',
            subtitle: e.publicador,
          ),
          if (e.cumplidor != null) ...[
            const SizedBox(height: 4),
            Text('La lleva ${e.cumplidor}', style: textTheme.bodyMedium),
          ],
          const SizedBox(height: 16),
          Text('Fotos de referencia', style: textTheme.titleSmall),
          const SizedBox(height: 8),
          if (e.fotos.isEmpty)
            Text(
              'Este encargo no tiene fotos guardadas.',
              style: textTheme.bodySmall
                  ?.copyWith(color: AppColors.textoSecundario),
            )
          else
            SizedBox(
              height: 140,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: e.fotos.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, i) {
                  return ClipRRect(
                    borderRadius:
                        BorderRadius.circular(AppConstants.radiusSmall),
                    child: Image.network(
                      e.fotos[i],
                      width: 180,
                      height: 140,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 180,
                        color: const Color(0xFFE2E8F0),
                        alignment: Alignment.center,
                        child: const Icon(Icons.broken_image_outlined),
                      ),
                    ),
                  );
                },
              ),
            ),
          const SizedBox(height: 24),
          if (widget.mode == DetailMode.cumplidor &&
              e.estado == EncomiendaEstado.abierta)
            FilledButton.icon(
              onPressed: _ocupado
                  ? null
                  : () => _ejecutar(
                        () =>
                            EncargosScope.of(context).aceptar(int.parse(e.id)),
                        'Aceptada. Quedó asignada al habitante ${ApiConfig.domiciliarioId}',
                      ),
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('Aceptar esta solicitud'),
            ),
          if (widget.mode == DetailMode.cumplidor &&
              e.estado == EncomiendaEstado.aceptada)
            FilledButton.icon(
              onPressed: _ocupado
                  ? null
                  : () => _ejecutar(
                        () => EncargosScope.of(context)
                            .cambiarEstado(int.parse(e.id), 'en camino'),
                        'Estado guardado: en camino',
                      ),
              icon: const Icon(Icons.route_outlined),
              label: const Text('Marcar en camino'),
            ),
          if (widget.mode == DetailMode.cumplidor &&
              e.estado == EncomiendaEstado.enCamino)
            FilledButton.icon(
              onPressed: _ocupado
                  ? null
                  : () => _ejecutar(
                        () => EncargosScope.of(context)
                            .cambiarEstado(int.parse(e.id), 'entregado'),
                        'Entrega guardada',
                      ),
              icon: const Icon(Icons.inventory_2_outlined),
              label: const Text('Marcar entregada'),
            ),
          if (widget.mode == DetailMode.publicador &&
              e.estado != EncomiendaEstado.cancelada &&
              e.estado != EncomiendaEstado.entregada &&
              e.estado != EncomiendaEstado.enCamino) ...[
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _ocupado
                  ? null
                  : () => _ejecutar(
                        () =>
                            EncargosScope.of(context).cancelar(int.parse(e.id)),
                        'Solicitud cancelada',
                      ),
              icon: const Icon(Icons.cancel_outlined),
              label: const Text('Cancelar solicitud'),
            ),
          ],
        ],
      ),
    );
  }
}

class _EstadoPill extends StatelessWidget {
  const _EstadoPill({required this.encomienda});

  final Encomienda encomienda;

  @override
  Widget build(BuildContext context) {
    final color = switch (encomienda.estado) {
      EncomiendaEstado.cancelada => AppColors.rojoInstitucional,
      EncomiendaEstado.aceptada ||
      EncomiendaEstado.enCamino =>
        AppColors.azulSistemas,
      _ => AppColors.verdeAmazonia,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        encomienda.estadoLabel,
        style: TextStyle(color: color, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon,
        color: AppColors.azulSistemas,
      ),
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
