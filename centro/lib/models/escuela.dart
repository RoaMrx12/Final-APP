import 'dart:convert';

class Escuela {
  final String codigo;
  final String nombre;
  final String direccion;
  final String telefono;

  Escuela({
    required this.codigo,
    required this.nombre,
    required this.direccion,
    required this.telefono,
  });

  factory Escuela.fromMap(Map<String, dynamic> json) => Escuela(
    codigo: json["codigo"],
    nombre: json["nombre"],
    direccion: json["direccion"],
    telefono: json["telefono"],
  );

  Map<String, dynamic> toMap() => {
    "codigo": codigo,
    "nombre": nombre,
    "direccion": direccion,
    "telefono": telefono,
  };

  String toJson() => json.encode(toMap());

  factory Escuela.fromJson(String source) => Escuela.fromMap(json.decode(source));
}
