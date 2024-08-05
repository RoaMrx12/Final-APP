import 'dart:convert';

class DetalleVisita {
  final int? id;
  final String cedulaDirector;
  final String codigoCentro;
  final String motivo;
  final String? fotoEvidenciaPath;
  final String comentario;
  final String? notaVozPath;
  final double latitud;
  final double longitud;
  final String fecha;
  final String hora;
  final int usuarioId;

  DetalleVisita({
    this.id,
    required this.cedulaDirector,
    required this.codigoCentro,
    required this.motivo,
    this.fotoEvidenciaPath,
    required this.comentario,
    this.notaVozPath,
    required this.latitud,
    required this.longitud,
    required this.fecha,
    required this.hora,
    required this.usuarioId,
  });

  factory DetalleVisita.fromMap(Map<String, dynamic> json) => DetalleVisita(
    id: json["id"],
    cedulaDirector: json["cedula_director"],
    codigoCentro: json["codigo_centro"],
    motivo: json["motivo"],
    fotoEvidenciaPath: json["foto_evidencia"],
    comentario: json["comentario"],
    notaVozPath: json["nota_voz"],
    latitud: json["latitud"],
    longitud: json["longitud"],
    fecha: json["fecha"],
    hora: json["hora"],
    usuarioId: json["usuario_id"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "cedula_director": cedulaDirector,
    "codigo_centro": codigoCentro,
    "motivo": motivo,
    "foto_evidencia": fotoEvidenciaPath,
    "comentario": comentario,
    "nota_voz": notaVozPath,
    "latitud": latitud,
    "longitud": longitud,
    "fecha": fecha,
    "hora": hora,
    "usuario_id": usuarioId,
  };

  String toJson() => json.encode(toMap());

  factory DetalleVisita.fromJson(String source) => DetalleVisita.fromMap(json.decode(source));
}
