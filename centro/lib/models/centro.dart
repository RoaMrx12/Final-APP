import 'dart:convert';

class Centro {
  final String idx;
  final String codigo;
  final String nombre;
  final String coordenadas;
  final String distrito;
  final String regional;
  final String dDmunicipal;

  Centro({
    required this.idx,
    required this.codigo,
    required this.nombre,
    required this.coordenadas,
    required this.distrito,
    required this.regional,
    required this.dDmunicipal,
  });

  // Constructor de fábrica para crear una instancia a partir de un mapa
  factory Centro.fromMap(Map<String, dynamic> json) => Centro(
  idx: json["idx"] ?? '',
  codigo: json["codigo"] ?? '',
  nombre: json["nombre"] ?? '',
  coordenadas: json["coordenadas"] ?? '',
  distrito: json["distrito"] ?? '',
  regional: json["regional"] ?? '',
  dDmunicipal: json["d_dmunicipal"] ?? '',
);

  // Método para convertir una instancia a un mapa
  Map<String, dynamic> toMap() => {
    "idx": idx,
    "codigo": codigo,
    "nombre": nombre,
    "coordenadas": coordenadas,
    "distrito": distrito,
    "regional": regional,
    "d_dmunicipal": dDmunicipal,
  };

  // Método para convertir una instancia a una cadena JSON
  String toJson() => json.encode(toMap());
  
  // Constructor de fábrica para crear una instancia a partir de una cadena JSON
  factory Centro.fromJson(String source) => Centro.fromMap(json.decode(source));
}
