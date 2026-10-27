import 'package:entrecomunidad/core/config/api_config.dart';
import 'package:entrecomunidad/core/constants/app_constants.dart';
import 'package:entrecomunidad/core/theme/app_colors.dart';
import 'package:entrecomunidad/features/encomiendas/data/encargos_api.dart';
import 'package:entrecomunidad/features/encomiendas/data/encargos_store.dart';
import 'package:entrecomunidad/core/theme/institutional_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

/// Rol publicador: describe, fotos, ubicación y cuánto paga.
class CreateEncomiendaScreen extends StatefulWidget {
  const CreateEncomiendaScreen({super.key});

  @override
  State<CreateEncomiendaScreen> createState() => _CreateEncomiendaScreenState();
}

class _CreateEncomiendaScreenState extends State<CreateEncomiendaScreen> {
  final _descCtrl = TextEditingController();
  final _origenCtrl = TextEditingController();
  final _destinoCtrl = TextEditingController();
  final _pagoCtrl = TextEditingController();
  final _fotos = <_FotoLocal>[];
  var _publicando = false;

  Future<void> _agregarFoto() async {
    if (_fotos.length >= 3) return;
    final archivo = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
      maxWidth: 1600,
    );
    if (archivo == null) return;
    final bytes = await archivo.readAsBytes();
    if (!mounted) return;
    setState(() {
      _fotos.add(_FotoLocal(bytes, archivo.name));
    });
  }

  @override
  void dispose() {
    _descCtrl.dispose();
    _origenCtrl.dispose();
    _destinoCtrl.dispose();
    _pagoCtrl.dispose();
    super.dispose();
  }

  Future<void> _publicar() async {
    if (_publicando) return;
    final pago = int.tryParse(_pagoCtrl.text.trim());
    if (_descCtrl.text.trim().isEmpty ||
        _origenCtrl.text.trim().isEmpty ||
        _destinoCtrl.text.trim().isEmpty ||
        pago == null ||
        pago <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completa descripción, rutas y pago')),
      );
      return;
    }
    setState(() => _publicando = true);
    try {
      final aviso = await EncargosScope.of(context).crear(
        descripcion: _descCtrl.text.trim(),
        origen: _origenCtrl.text.trim(),
        destino: _destinoCtrl.text.trim(),
        pago: pago,
        fotos: [
          for (final foto in _fotos)
            FotoAdjunto(bytes: foto.bytes, nombre: foto.nombre),
        ],
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            aviso ??
                'Solicitud publicada como habitante ${ApiConfig.solicitanteId}',
          ),
        ),
      );
      Navigator.of(context).pop();
    } on EncargosApiException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo publicar en el backend')),
      );
    } finally {
      if (mounted) setState(() => _publicando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InstitutionalPalette.pageBackground,
      appBar: AppBar(
        title: const Text('Nueva solicitud'),
        backgroundColor: AppColors.blanco,
        foregroundColor: AppColors.texto,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _publicando ? null : _publicar,
            child: const Text('Publicar'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Se guarda en la base: qué llevar, de dónde a dónde, el pago '
            'y hasta 3 fotos. Queda publicada a nombre del habitante '
            '${ApiConfig.solicitanteId}.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textoSecundario,
                ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _descCtrl,
            maxLines: 5,
            decoration: const InputDecoration(
              labelText: '¿Qué necesitas que te lleven?',
              hintText: 'Ej: caja con medicamentos, frágil, aprox. 2 kg…',
              alignLabelWithHint: true,
              filled: true,
              fillColor: AppColors.blanco,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _origenCtrl,
            decoration: const InputDecoration(
              labelText: 'Origen / punto de recogida',
              hintText: 'Ej: Travecias — centro',
              prefixIcon: Icon(Icons.place_outlined),
              filled: true,
              fillColor: AppColors.blanco,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _destinoCtrl,
            decoration: const InputDecoration(
              labelText: 'Destino',
              prefixIcon: Icon(Icons.flag_outlined),
              filled: true,
              fillColor: AppColors.blanco,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _pagoCtrl,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: 'Cuánto pagas (COP)',
              prefixText: '\$ ',
              filled: true,
              fillColor: AppColors.blanco,
            ),
          ),
          const SizedBox(height: 20),
          Text('Fotos de referencia', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (var i = 0; i < _fotos.length; i++)
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                      child: Image.memory(
                        _fotos[i].bytes,
                        width: 72,
                        height: 72,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 2,
                      right: 2,
                      child: GestureDetector(
                        onTap: () => setState(() => _fotos.removeAt(i)),
                        child: const CircleAvatar(
                          radius: 10,
                          backgroundColor: AppColors.rojoInstitucional,
                          child: Icon(Icons.close, size: 12, color: AppColors.blanco),
                        ),
                      ),
                    ),
                  ],
                ),
              if (_fotos.length < 3)
                InkWell(
                  onTap: _publicando ? null : _agregarFoto,
                  borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppColors.blanco,
                      borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                      border: Border.all(
                        color: AppColors.textoSecundario.withValues(alpha: 0.35),
                      ),
                    ),
                    child: const Icon(Icons.add_a_photo_outlined),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: _publicando ? null : _publicar,
            icon: const Icon(Icons.publish_outlined),
            label: const Text('Publicar solicitud'),
          ),
        ],
      ),
    );
  }
}

class _FotoLocal {
  const _FotoLocal(this.bytes, this.nombre);

  final Uint8List bytes;
  final String nombre;
}
