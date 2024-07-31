class Usuario {
  final String nombre;
  final String apellido;
  final String matricula;
  final String password;

  Usuario({
    required this.nombre,
    required this.apellido,
    required this.matricula,
    required this.password,
  });

  factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
    nombre: json['nombre'],
    apellido: json['apellido'],
    matricula: json['matricula'],
    password: json['password'],
  );

  Map<String, dynamic> toMap() => {
    'nombre': nombre,
    'apellido': apellido,
    'matricula': matricula,
    'password': password,
  };
}
