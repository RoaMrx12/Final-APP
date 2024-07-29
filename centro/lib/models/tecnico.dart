import 'dart:convert';

class Tecnico {
  final int? id;
  final String nombre;
  final String apellido;
  final String matricula;
  final String? fotoPath;
  final String reflexion;

  Tecnico({
    this.id,
    required this.nombre,
    required this.apellido,
    required this.matricula,
    this.fotoPath,
    required this.reflexion,
  });

  factory Tecnico.fromMap(Map<String, dynamic> json) => Tecnico(
    id: json["id"],
    nombre: json["nombre"],
    apellido: json["apellido"],
    matricula: json["matricula"],
    fotoPath: json["fotoPath"],
    reflexion: json["reflexion"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "nombre": nombre,
    "apellido": apellido,
    "matricula": matricula,
    "fotoPath": fotoPath,
    "reflexion": reflexion,
  };

  String toJson() => json.encode(toMap());

  factory Tecnico.fromJson(String source) => Tecnico.fromMap(json.decode(source));
}
