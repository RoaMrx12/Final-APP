import 'dart:convert';

class Tecnico {
  final int? id;
  final String cedula;
  final String nombre;
  final String apellido;
  final String clave;
  final String correo;
  final String telefono;
  final String fechaNacimiento;

  Tecnico({
    this.id,
    required this.cedula,
    required this.nombre,
    required this.apellido,
    required this.clave,
    required this.correo,
    required this.telefono,
    required this.fechaNacimiento,
  });

  factory Tecnico.fromMap(Map<String, dynamic> json) => Tecnico(
    id: json["id"],
    cedula: json["cedula"],
    nombre: json["nombre"],
    apellido: json["apellido"],
    clave: json["clave"],
    correo: json["correo"],
    telefono: json["telefono"],
    fechaNacimiento: json["fecha_nacimiento"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "cedula": cedula,
    "nombre": nombre,
    "apellido": apellido,
    "clave": clave,
    "correo": correo,
    "telefono": telefono,
    "fecha_nacimiento": fechaNacimiento,
  };

  String toJson() => json.encode(toMap());

  factory Tecnico.fromJson(String source) => Tecnico.fromMap(json.decode(source));
}
