import 'dart:convert';

import 'package:centro/models/visitas/detalleVisita.dart';

class Situacion {
  final int? id;
  final String cedulaDirector;
  final String codigoCentro;
  final String motivo;
  final String latitud;
  final String longitud;
  final String fecha;
  final String hora;

  Situacion({
    this.id,
    required this.cedulaDirector,
    required this.codigoCentro,
    required this.motivo,
    required this.latitud,
    required this.longitud,
    required this.fecha,
    required this.hora,
  });

  factory Situacion.fromMap(Map<String, dynamic> json) => Situacion(
    id: json["id"] != null ? int.tryParse(json["id"]) : null,
    cedulaDirector: json["cedula_director"],
    codigoCentro: json["codigo_centro"],
    motivo: json["motivo"],
    latitud: json["latitud"].toString(),
    longitud: json["longitud"].toString(),
    fecha: json["fecha"],
    hora: json["hora"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "cedula_director": cedulaDirector,
    "codigo_centro": codigoCentro,
    "motivo": motivo,
    "latitud": latitud,
    "longitud": longitud,
    "fecha": fecha,
    "hora": hora,
  };

  factory Situacion.fromJson(String source) => Situacion.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  // Conversión a DetalleVisita
  DetalleVisita toDetalleVisita() {
    return DetalleVisita(
      cedulaDirector: cedulaDirector,
      codigoCentro: codigoCentro,
      motivo: motivo,
      comentario: "", // Asignar campos vacíos o valores por defecto según sea necesario
      latitud: double.tryParse(latitud)!,
      longitud: double.tryParse(longitud)!,
      fecha: fecha,
      hora: hora,
      fotoEvidenciaPath: "",
      notaVozPath: "", 
      usuarioId: 0,
    );
  }
}
