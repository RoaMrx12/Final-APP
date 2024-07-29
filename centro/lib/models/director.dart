import 'dart:convert';

class Director {
  final String cedula;
  final String nombre;
  final String apellido;
  final String fechaNacimiento;
  final String direccion;
  final String telefono;
  final String? fotoPath;

  Director({
    required this.cedula,
    required this.nombre,
    required this.apellido,
    required this.fechaNacimiento,
    required this.direccion,
    required this.telefono,
    this.fotoPath,
  });

  // Constructor de fábrica para crear una instancia a partir de un mapa
  factory Director.fromMap(Map<String, dynamic> json) => Director(
    cedula: json["cedula"],
    nombre: json["nombre"],
    apellido: json["apellido"],
    fechaNacimiento: json["fechaNacimiento"],
    direccion: json["direccion"],
    telefono: json["telefono"],
    fotoPath: json["fotoPath"],
  );

  // Método para convertir una instancia a un mapa
  Map<String, dynamic> toMap() => {
        "cedula": cedula,
        "nombre": nombre,
        "apellido": apellido,
        "fechaNacimiento": fechaNacimiento,
        "direccion": direccion,
        "telefono": telefono,
        "fotoPath": fotoPath,
  };

  // Método para convertir una instancia a una cadena JSON
  String toJson() => json.encode(toMap());
  
  // Constructor de fábrica para crear una instancia a partir de una cadena JSON
  factory Director.fromJson(String source) => Director.fromMap(json.decode(source));
}
