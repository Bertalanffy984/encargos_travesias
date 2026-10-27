class ActividadAviso {
  const ActividadAviso({
    required this.id,
    required this.estado,
    required this.descripcion,
    required this.solicitante,
    required this.fecha,
  });

  final String id;
  final String estado;
  final String descripcion;
  final String solicitante;
  final DateTime? fecha;

  factory ActividadAviso.fromJson(Map<String, dynamic> json) {
    return ActividadAviso(
      id: '${json['id_historial']}',
      estado: (json['nombre_estado'] ?? '').toString(),
      descripcion: (json['descripcion'] ?? '').toString(),
      solicitante: (json['solicitante'] ?? '').toString(),
      fecha: DateTime.tryParse('${json['fecha_inicio']}'),
    );
  }

  String get titulo {
    final quien = solicitante.isEmpty ? 'Un encargo' : solicitante;
    final estadoLabel = estado.isEmpty ? 'actualizado' : estado;
    return '$quien · $estadoLabel';
  }

  String get subtitulo {
    final cuando = fecha == null
        ? ''
        : ' · ${fecha!.day}/${fecha!.month}/${fecha!.year} '
            '${fecha!.hour.toString().padLeft(2, '0')}:'
            '${fecha!.minute.toString().padLeft(2, '0')}';
    return '$descripcion$cuando';
  }
}
