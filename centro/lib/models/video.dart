import 'dart:convert';

class Video {
  final String id;
  final String fecha;
  final String titulo;
  final String descripcion;
  final String link;

  Video({
    required this.id,
    required this.fecha,
    required this.titulo,
    required this.descripcion,
    required this.link,
  });

  factory Video.fromMap(Map<String, dynamic> json) => Video(
    id: json["id"],
    fecha: json["fecha"],
    titulo: json["titulo"],
    descripcion: json["descripcion"],
    link: json["link"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "fecha": fecha,
    "titulo": titulo,
    "descripcion": descripcion,
    "link": link,
  };

  String toJson() => json.encode(toMap());

  factory Video.fromJson(String source) => Video.fromMap(json.decode(source));
}
