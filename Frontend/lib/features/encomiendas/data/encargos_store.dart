import 'package:entrecomunidad/core/config/api_config.dart';
import 'package:entrecomunidad/features/encomiendas/data/encargos_api.dart';
import 'package:entrecomunidad/features/encomiendas/domain/actividad_aviso.dart';
import 'package:entrecomunidad/features/encomiendas/domain/encomienda.dart';
import 'package:flutter/widgets.dart';

class EncargosStore extends ChangeNotifier {
  EncargosStore({EncargosApi? api}) : _api = api ?? EncargosApi();

  final EncargosApi _api;

  List<Encomienda> disponibles = const [];
  List<Encomienda> publicadas = const [];
  List<Encomienda> asignadas = const [];
  List<ActividadAviso> actividad = const [];
  bool cargando = false;
  String? error;

  Future<void> refresh({bool silencioso = false}) async {
    if (!silencioso) {
      cargando = true;
      error = null;
      notifyListeners();
    }
    try {
      final nuevasDisponibles = await _api.disponibles();
      final nuevasPublicadas = await _api.porSolicitante(ApiConfig.solicitanteId);
      final nuevasAsignadas = await _api.porDomiciliario(ApiConfig.domiciliarioId);
      final nuevaActividad = await _api.actividad();
      disponibles = nuevasDisponibles;
      publicadas = nuevasPublicadas;
      asignadas = nuevasAsignadas;
      actividad = nuevaActividad;
      error = null;
    } on EncargosApiException catch (e) {
      error = e.message;
    } catch (_) {
      error = 'No se pudo conectar con el backend en ${ApiConfig.baseUrl}';
    } finally {
      cargando = false;
      notifyListeners();
    }
  }

  Future<String?> crear({
    required String descripcion,
    required String origen,
    required String destino,
    required int pago,
    List<FotoAdjunto> fotos = const [],
  }) async {
    final id = await _api.crear(
      solicitanteId: ApiConfig.solicitanteId,
      descripcion: descripcion,
      origen: origen,
      destino: destino,
      pago: pago,
    );
    var fallidas = 0;
    for (final foto in fotos) {
      try {
        await _api.subirFoto(
          idEncargo: id,
          bytes: foto.bytes,
          nombre: foto.nombre,
        );
      } catch (_) {
        fallidas++;
      }
    }
    await refresh(silencioso: true);
    if (fallidas > 0) {
      return 'La solicitud quedó guardada, pero $fallidas foto${fallidas == 1 ? '' : 's'} no se pudo subir';
    }
    return null;
  }

  Future<void> cambiarEstado(int idEncargo, String estado) async {
    await _api.cambiarEstado(idEncargo: idEncargo, estado: estado);
    await refresh(silencioso: true);
  }

  Future<void> aceptar(int idEncargo) async {
    await _api.aceptar(
      idEncargo: idEncargo,
      idDomiciliario: ApiConfig.domiciliarioId,
    );
    await refresh(silencioso: true);
  }

  Future<void> cancelar(int idEncargo) async {
    await _api.cancelar(idEncargo);
    await refresh(silencioso: true);
  }
}

class EncargosScope extends InheritedNotifier<EncargosStore> {
  const EncargosScope({
    super.key,
    required EncargosStore store,
    required super.child,
  }) : super(notifier: store);

  static EncargosStore of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<EncargosScope>();
    assert(scope != null, 'EncargosScope no está en el árbol');
    return scope!.notifier!;
  }
}
