import 'dart:convert';

class Situacion {
  final int? id;
  final String cedulaDirector;
  final String codigoCentro;
  final String motivo;
  final double latitud;
  final double longitud;
  final String hora;
  final String fecha;

  Situacion({
    this.id,
    required this.cedulaDirector,
    required this.codigoCentro,
    required this.motivo,
    required this.latitud,
    required this.longitud,
    required this.hora,
    required this.fecha,
  });

  factory Situacion.fromMap(Map<String, dynamic> json) => Situacion(
    id: json["id"],
    cedulaDirector: json["cedula_director"],
    codigoCentro: json["codigo_centro"],
    motivo: json["motivo"],
    latitud: json["latitud"],
    longitud: json["longitud"],
    hora: json["hora"],
    fecha: json["fecha"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "cedula_director": cedulaDirector,
    "codigo_centro": codigoCentro,
    "motivo": motivo,
    "latitud": latitud,
    "longitud": longitud,
    "hora": hora,
    "fecha": fecha,
  };

  String toJson() => json.encode(toMap());

  factory Situacion.fromJson(String source) => Situacion.fromMap(json.decode(source));
}
