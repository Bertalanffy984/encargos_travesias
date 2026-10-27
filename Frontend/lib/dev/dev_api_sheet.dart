import 'package:entrecomunidad/core/config/api_config.dart';
import 'package:entrecomunidad/core/network/api_client.dart';
import 'package:flutter/material.dart';

/// Solo para desarrolladores — no es pantalla de usuario final.
Future<void> showDevApiSheet(BuildContext context) async {
  var status = 'Pulsa comprobar';
  var checking = false;

  await showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          Future<void> check() async {
            setModalState(() {
              checking = true;
              status = 'Comprobando…';
            });
            try {
              final r = await ApiClient().get(ApiEndpoints.health);
              setModalState(() {
                status = r.statusCode == 200
                    ? 'OK (${r.statusCode})'
                    : 'Código ${r.statusCode}';
              });
            } catch (e) {
              setModalState(() {
                status = 'Sin conexión · ${ApiConfig.baseUrl}';
              });
            } finally {
              setModalState(() => checking = false);
            }
          }

          return Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Herramientas de desarrollo',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text('Base URL: ${ApiConfig.baseUrl}'),
                Text(status),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: checking ? null : check,
                  child: Text(checking ? 'Comprobando…' : 'Probar /health'),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
