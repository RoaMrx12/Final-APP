import 'dart:convert';

class LoginRequest {
  final String cedula;
  final String clave;

  LoginRequest({
    required this.cedula,
    required this.clave,
  });

  factory LoginRequest.fromMap(Map<String, dynamic> json) => LoginRequest(
        cedula: json["cedula"],
        clave: json["clave"],
      );

  Map<String, dynamic> toMap() => {
        "cedula": cedula,
        "clave": clave,
      };

  String toJson() => json.encode(toMap());

  factory LoginRequest.fromJson(String source) =>
      LoginRequest.fromMap(json.decode(source));
}
