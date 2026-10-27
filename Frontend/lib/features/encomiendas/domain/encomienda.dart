import 'dart:convert';

/// Modelo de un encargo guardado en MySQL.
enum EncomiendaEstado {
  abierta,
  negociando,
  aceptada,
  enCamino,
  entregada,
  cancelada,
}

class Encomienda {
  const Encomienda({
    required this.id,
    required this.descripcion,
    required this.ubicacionOrigen,
    required this.ubicacionDestino,
    required this.pagoOfertado,
    required this.publicador,
    required this.estado,
    this.fotoCount = 1,
    this.fotos = const [],
    this.contraOferta,
    this.cumplidor,
  });

  final String id;
  final String descripcion;
  final String ubicacionOrigen;
  final String ubicacionDestino;
  final int pagoOfertado;
  final String publicador;
  final EncomiendaEstado estado;
  final int fotoCount;
  final List<String> fotos;
  final int? contraOferta;
  final String? cumplidor;

  factory Encomienda.fromJson(Map<String, dynamic> json) {
    final ubicacion = (json['descripcion_ubicacion'] ?? '').toString().trim();
    final partes = ubicacion.split(' → ');
    final origen = partes.first.isEmpty ? 'Sin ubicación' : partes.first;
    final destino = partes.length > 1 ? partes.sublist(1).join(' → ') : '';
    final pago = json['remuneracion'];
    final cantidadFotos = json['foto_count'];

    return Encomienda(
      id: '${json['id_encargo']}',
      descripcion: (json['descripcion'] ?? '').toString(),
      ubicacionOrigen: origen,
      ubicacionDestino: destino,
      pagoOfertado: pago is num ? pago.round() : int.tryParse('$pago') ?? 0,
      publicador: (json['solicitante'] ?? 'Habitante ${json['fk_solicitante']}')
          .toString(),
      estado: estadoDesdeApi(json['estado_actual']),
      fotoCount: cantidadFotos is num
          ? cantidadFotos.round()
          : int.tryParse('$cantidadFotos') ?? 0,
      fotos: _enlaces(json['fotos']),
      cumplidor: json['domiciliario']?.toString(),
    );
  }

  String get estadoLabel => switch (estado) {
        EncomiendaEstado.abierta => 'Abierta',
        EncomiendaEstado.negociando => 'Negociando',
        EncomiendaEstado.aceptada => 'Aceptada',
        EncomiendaEstado.enCamino => 'En camino',
        EncomiendaEstado.entregada => 'Entregada',
        EncomiendaEstado.cancelada => 'Cancelada',
      };

  String get pagoFormateado => formatoCop(pagoOfertado);
}

String formatoCop(int valor) {
  final digitos = valor.abs().toString();
  final buffer = StringBuffer(valor < 0 ? '-' : '');
  buffer.write('\$');
  for (var i = 0; i < digitos.length; i++) {
    if (i > 0 && (digitos.length - i) % 3 == 0) buffer.write('.');
    buffer.write(digitos[i]);
  }
  return buffer.toString();
}

List<String> _enlaces(Object? raw) {
  if (raw is List) {
    return raw.map((item) => '$item').where((item) => item.isNotEmpty).toList();
  }
  if (raw is String && raw.isNotEmpty) {
    try {
      final decoded = jsonDecode(raw);
      if (decoded is List) {
        return decoded.map((item) => '$item').where((item) => item.isNotEmpty).toList();
      }
    } catch (_) {}
  }
  return const [];
}

EncomiendaEstado estadoDesdeApi(Object? valor) {
  return switch ('$valor'.toLowerCase()) {
    'aceptado' => EncomiendaEstado.aceptada,
    'en camino' => EncomiendaEstado.enCamino,
    'entregado' => EncomiendaEstado.entregada,
    'cancelado' => EncomiendaEstado.cancelada,
    _ => EncomiendaEstado.abierta,
  };
}

/// Datos de demostración — comunidad Travecias.
abstract final class EncomiendasMock {
  static final List<Encomienda> disponibles = [
    const Encomienda(
      id: '1',
      descripcion:
          'Llevar un paquete mediano (medicamentos) del centro de Travecias '
          'a la vereda El Mirador. Caja pequeña, frágil.',
      ubicacionOrigen: 'Travecias — centro',
      ubicacionDestino: 'Vereda El Mirador, Travecias',
      pagoOfertado: 35000,
      publicador: 'María González',
      estado: EncomiendaEstado.abierta,
      fotoCount: 2,
    ),
    const Encomienda(
      id: '2',
      descripcion:
          'Enviar documentos y un sobre con papeles de la finca. Urgente para mañana.',
      ubicacionOrigen: 'Travecias — caserío Norte',
      ubicacionDestino: 'Travecias — plaza',
      pagoOfertado: 25000,
      publicador: 'Carlos Restrepo',
      estado: EncomiendaEstado.abierta,
      fotoCount: 1,
    ),
    const Encomienda(
      id: '3',
      descripcion:
          'Llevar mercado (arroz, aceite, café) a la vereda La Esperanza. '
          'Aprox. 8 kg en 2 bolsas.',
      ubicacionOrigen: 'Travecias — tienda comunitaria',
      ubicacionDestino: 'Vereda La Esperanza, Travecias',
      pagoOfertado: 45000,
      publicador: 'Ana Lucía Pérez',
      estado: EncomiendaEstado.negociando,
      fotoCount: 3,
      contraOferta: 55000,
      cumplidor: 'José Ramírez',
    ),
  ];

  static final List<Encomienda> mias = [
    const Encomienda(
      id: '4',
      descripcion: 'Paquete con ropa y zapatos para mi hermana en la vereda San José.',
      ubicacionOrigen: 'Travecias — centro',
      ubicacionDestino: 'Vereda San José, Travecias',
      pagoOfertado: 40000,
      publicador: 'Luis Andrade',
      estado: EncomiendaEstado.enCamino,
      fotoCount: 2,
      cumplidor: 'Pedro Hoyos',
    ),
    disponibles[0],
  ];
}
