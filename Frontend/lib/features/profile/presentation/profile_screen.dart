import 'package:entrecomunidad/core/config/api_config.dart';
import 'package:entrecomunidad/core/constants/app_constants.dart';
import 'package:entrecomunidad/core/theme/app_colors.dart';
import 'package:entrecomunidad/core/theme/institutional_palette.dart';
import 'package:entrecomunidad/dev/dev_api_sheet.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _devTaps = 0;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: InstitutionalPalette.pageBackground,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
        children: [
          Text(
            'Cómo se guarda',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 8),
            height: 3,
            width: 40,
            color: InstitutionalPalette.accentLine,
          ),
          Text(
            'Esta app no tiene usuarios propios. Cada acción usa un habitante '
            'que ya está en MySQL.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textoSecundario,
                ),
          ),
          const SizedBox(height: 16),
          _RolCard(
            icon: Icons.edit_outlined,
            titulo: 'Quien publica',
            detalle: 'Habitante ${ApiConfig.solicitanteId}',
            texto: 'Solicitar crea el encargo, la ruta, el pago y las fotos.',
          ),
          const SizedBox(height: 10),
          _RolCard(
            icon: Icons.local_shipping_outlined,
            titulo: 'Quien lleva',
            detalle: 'Habitante ${ApiConfig.domiciliarioId}',
            texto: 'Aceptar, marcar en camino y marcar entregada actualizan la base.',
          ),
          const SizedBox(height: 16),
          Material(
            color: InstitutionalPalette.card,
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
            child: ListTile(
              leading: const Icon(Icons.storage_outlined, color: AppColors.azulSistemas),
              title: const Text('Servidor'),
              subtitle: Text(ApiConfig.baseUrl),
            ),
          ),
          GestureDetector(
            onTap: () {
              _devTaps++;
              if (_devTaps >= 7) {
                _devTaps = 0;
                showDevApiSheet(context);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Versión 0.1.0',
                style: Theme.of(context).textTheme.labelSmall,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RolCard extends StatelessWidget {
  const _RolCard({
    required this.icon,
    required this.titulo,
    required this.detalle,
    required this.texto,
  });

  final IconData icon;
  final String titulo;
  final String detalle;
  final String texto;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.blanco,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        side: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.verdeAmazonia.withValues(alpha: 0.12),
              child: Icon(icon, color: AppColors.verdeAmazonia),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(titulo, style: const TextStyle(fontWeight: FontWeight.w700)),
                  Text(
                    detalle,
                    style: const TextStyle(
                      color: AppColors.azulSistemas,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    texto,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textoSecundario,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
