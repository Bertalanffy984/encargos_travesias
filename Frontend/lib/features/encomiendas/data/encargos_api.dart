import 'dart:convert';

import 'package:entrecomunidad/core/config/api_config.dart';
import 'package:entrecomunidad/core/network/api_client.dart';
import 'package:entrecomunidad/features/encomiendas/domain/actividad_aviso.dart';
import 'package:entrecomunidad/features/encomiendas/domain/encomienda.dart';

class EncargosApiException implements Exception {
  EncargosApiException(this.message);

  final String message;

  @override
  String toString() => message;
}

class FotoAdjunto {
  const FotoAdjunto({required this.bytes, required this.nombre});

  final List<int> bytes;
  final String nombre;
}

class EncargosApi {
  EncargosApi({ApiClient? client}) : _client = client ?? ApiClient();

  final ApiClient _client;

  Future<List<Encomienda>> disponibles() async {
    final data = await _getData(ApiEndpoints.disponibles);
    return _encomiendas(data);
  }

  Future<List<Encomienda>> porSolicitante(int id) async {
    final data = await _getData(ApiEndpoints.porSolicitante(id));
    return _encomiendas(data);
  }

  Future<List<Encomienda>> porDomiciliario(int id) async {
    final data = await _getData(ApiEndpoints.porDomiciliario(id));
    return _encomiendas(data);
  }

  Future<List<ActividadAviso>> actividad() async {
    final data = await _getData(ApiEndpoints.actividad);
    if (data is! List) return const [];
    return data
        .whereType<Map>()
        .map((row) => ActividadAviso.fromJson(Map<String, dynamic>.from(row)))
        .toList();
  }

  Future<int> crear({
    required int solicitanteId,
    required String descripcion,
    required String origen,
    required String destino,
    required int pago,
  }) async {
    final data = await _post(ApiEndpoints.crear, {
      'fk_solicitante': solicitanteId,
      'descripción': descripcion,
      'descripcion_ubicacion': '$origen → $destino',
      'remuneración': pago,
    });
    final id = data is Map ? data['id_encargo'] : null;
    final parsed = int.tryParse('$id');
    if (parsed == null) {
      throw EncargosApiException('El backend no devolvió el id del encargo');
    }
    return parsed;
  }

  Future<void> subirFoto({
    required int idEncargo,
    required List<int> bytes,
    required String nombre,
  }) async {
    final response = await _client.postFile(
      ApiEndpoints.subirFoto,
      fieldName: 'foto',
      bytes: bytes,
      filename: nombre,
      fields: {'fk_encargo': '$idEncargo'},
    );
    _data(response.statusCode, response.body);
  }

  Future<void> cambiarEstado({
    required int idEncargo,
    required String estado,
  }) async {
    final response = await _client.put(ApiEndpoints.estado, body: {
      'fk_encargo': idEncargo,
      'estado_actual': estado,
    });
    _data(response.statusCode, response.body);
  }

  Future<void> aceptar({
    required int idEncargo,
    required int idDomiciliario,
  }) async {
    await _post(ApiEndpoints.aceptar, {
      'fk_encargo': idEncargo,
      'fk_domiciliario': idDomiciliario,
    });
  }

  Future<void> cancelar(int idEncargo) async {
    await _post(ApiEndpoints.cancelar, {'fk_encargo': idEncargo});
  }

  List<Encomienda> _encomiendas(Object? data) {
    if (data is! List) return const [];
    return data
        .whereType<Map>()
        .map((row) => Encomienda.fromJson(Map<String, dynamic>.from(row)))
        .toList();
  }

  Future<Object?> _getData(String path) async {
    final response = await _client.get(path);
    return _data(response.statusCode, response.body);
  }

  Future<Object?> _post(String path, Map<String, Object> body) async {
    final response = await _client.post(path, body: body);
    return _data(response.statusCode, response.body);
  }

  Object? _data(int statusCode, String body) {
    Object? decoded;
    try {
      decoded = jsonDecode(body);
    } catch (_) {
      throw EncargosApiException('El backend respondió $statusCode');
    }
    if (decoded is! Map || statusCode >= 400 || decoded['success'] == false) {
      final message = decoded is Map ? decoded['message']?.toString() : null;
      throw EncargosApiException(message ?? 'Error $statusCode');
    }
    return decoded['data'];
  }
}
