import 'dart:convert';

class Visita {
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

  Visita({
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
  });

  factory Visita.fromMap(Map<String, dynamic> json) => Visita(
    id: json["id"],
    cedulaDirector: json["cedulaDirector"],
    codigoCentro: json["codigoCentro"],
    motivo: json["motivo"],
    fotoEvidenciaPath: json["fotoEvidenciaPath"],
    comentario: json["comentario"],
    notaVozPath: json["notaVozPath"],
    latitud: json["latitud"],
    longitud: json["longitud"],
    fecha: json["fecha"],
    hora: json["hora"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "cedulaDirector": cedulaDirector,
    "codigoCentro": codigoCentro,
    "motivo": motivo,
    "fotoEvidenciaPath": fotoEvidenciaPath,
    "comentario": comentario,
    "notaVozPath": notaVozPath,
    "latitud": latitud,
    "longitud": longitud,
    "fecha": fecha,
    "hora": hora,
  };

  String toJson() => json.encode(toMap());

  factory Visita.fromJson(String source) => Visita.fromMap(json.decode(source));
}
