import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Configuración de API para integración con backend (MySQL vía REST, etc.).
///
/// El compañero de backend debe exponer endpoints bajo [baseUrl].
/// Copiar `.env.example` → `.env` y definir `API_BASE_URL`.
abstract final class ApiConfig {
  static String get baseUrl =>
      dotenv.maybeGet('API_BASE_URL') ?? 'http://localhost:3000';

  /// Habitante del SQL de prueba que publica (Carlos, id 1).
  static int get solicitanteId =>
      int.tryParse(dotenv.maybeGet('SOLICITANTE_ID') ?? '') ?? 1;

  /// Habitante del SQL de prueba que acepta encargos (Natalia, id 6).
  static int get domiciliarioId =>
      int.tryParse(dotenv.maybeGet('DOMICILIARIO_ID') ?? '') ?? 6;

  static Duration get timeout => Duration(
        seconds: int.tryParse(dotenv.maybeGet('API_TIMEOUT_SECONDS') ?? '') ??
            30,
      );

}

/// Rutas reales de encargos_travesias.
abstract final class ApiEndpoints {
  static const String health = '/health';
  static const String disponibles = '/encargos/disponibles';
  static const String crear = '/encargos/crear';
  static const String actividad = '/encargos/actividad';
  static const String aceptar = '/encargos/aceptar';
  static const String cancelar = '/creador/cancelar';
  static const String estado = '/encargos/actualizarEstado';
  static const String subirFoto = '/fotos/subir';

  static String porSolicitante(int id) => '/encargos/solicitante/$id';
  static String porDomiciliario(int id) => '/encargos/domiciliario/$id';
}
