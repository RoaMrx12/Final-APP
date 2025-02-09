import 'dart:convert';

class Visita {
  final int? id;
  final String cedulaDirector;
  final String codigoCentro;
  final String motivo;
  final String fotoPath;
  final String comentario;
  final String audioPath;
  final String latitud;
  final String longitud;
  final String fecha;
  final String hora;
  final String token;

  Visita({
    this.id,
    required this.cedulaDirector,
    required this.codigoCentro,
    required this.motivo,
    required this.fotoPath,
    required this.comentario,
    required this.audioPath,
    required this.latitud,
    required this.longitud,
    required this.fecha,
    required this.hora,
    required this.token,
  });

  factory Visita.fromMap(Map<String, dynamic> json) => Visita(
    id: json["id"] is int ? json["id"] : int.tryParse(json["id"] ?? '0'),
    cedulaDirector: json["cedulaDirector"],
    codigoCentro: json["codigoCentro"],
    motivo: json["motivo"],
    fotoPath: json["fotoPath"],
    comentario: json["comentario"],
    audioPath: json["audioPath"],
    latitud: json["latitud"].toString(),
    longitud: json["longitud"].toString(),
    fecha: json["fecha"],
    hora: json["hora"],
    token: '' 
  );

  Map<String, dynamic> toMap() => {
  "id": id,
  "cedulaDirector": cedulaDirector,
  "codigoCentro": codigoCentro,
  "motivo": motivo,
  "fotoPath": fotoPath,
  "comentario": comentario,
  "audioPath": audioPath,
  "latitud": latitud,
  "longitud": longitud,
  "fecha": fecha,
  "hora": hora,
};

  factory Visita.fromJson(String source) => Visita.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
