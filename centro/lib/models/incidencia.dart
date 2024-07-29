import 'dart:convert';

class Incidencia {
  final int? id;
  final String titulo;
  final String centroEducativo;
  final String regional;
  final String distrito;
  final String fecha;
  final String descripcion;
  final String? fotoPath;
  final String? audioPath;

  Incidencia({
    this.id,
    required this.titulo,
    required this.centroEducativo,
    required this.regional,
    required this.distrito,
    required this.fecha,
    required this.descripcion,
    this.fotoPath,
    this.audioPath,
  });

  factory Incidencia.fromMap(Map<String, dynamic> json) => Incidencia(
    id: json["id"],
    titulo: json["titulo"],
    centroEducativo: json["centroEducativo"],
    regional: json["regional"],
    distrito: json["distrito"],
    fecha: json["fecha"],
    descripcion: json["descripcion"],
    fotoPath: json["fotoPath"],
    audioPath: json["audioPath"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "titulo": titulo,
    "centroEducativo": centroEducativo,
    "regional": regional,
    "distrito": distrito,
    "fecha": fecha,
    "descripcion": descripcion,
    "fotoPath": fotoPath,
    "audioPath": audioPath,
  };

  String toJson() => json.encode(toMap());

  factory Incidencia.fromJson(String source) => Incidencia.fromMap(json.decode(source));
}
