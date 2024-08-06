import 'dart:convert';

class RecuperarClaveRequest {
  final String cedula;
  final String correo;

  RecuperarClaveRequest({
    required this.cedula,
    required this.correo,
  });

  factory RecuperarClaveRequest.fromMap(Map<String, dynamic> json) => RecuperarClaveRequest(
        cedula: json["cedula"],
        correo: json["correo"],
      );

  Map<String, dynamic> toMap() => {
        "cedula": cedula,
        "correo": correo,
      };

  String toJson() => json.encode(toMap());

  factory RecuperarClaveRequest.fromJson(String source) =>
      RecuperarClaveRequest.fromMap(json.decode(source));
}
