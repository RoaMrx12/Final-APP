import 'dart:convert';

class CambiarClaveRequest {
  final String token;
  final String claveAnterior;
  final String claveNueva;

  CambiarClaveRequest({
    required this.token,
    required this.claveAnterior,
    required this.claveNueva,
  });

  Map<String, dynamic> toMap() => {
    "token": token,
    "clave_anterior": claveAnterior,
    "clave_nueva": claveNueva,
  };

  String toJson() => json.encode(toMap());

  factory CambiarClaveRequest.fromJson(String source) => CambiarClaveRequest.fromMap(json.decode(source));

  factory CambiarClaveRequest.fromMap(Map<String, dynamic> map) => CambiarClaveRequest(
    token: map["token"],
    claveAnterior: map["clave_anterior"],
    claveNueva: map["clave_nueva"],
  );
}
