import 'dart:convert';

class SituacionRequest {
  final String token;
  final int situacionId;

  SituacionRequest({
    required this.token,
    required this.situacionId,
  });

  Map<String, dynamic> toMap() => {
    "token": token,
    "situacion_id": situacionId,
  };

  String toJson() => json.encode(toMap());

  factory SituacionRequest.fromJson(String source) => SituacionRequest.fromMap(json.decode(source));

  factory SituacionRequest.fromMap(Map<String, dynamic> map) => SituacionRequest(
    token: map["token"],
    situacionId: map["situacion_id"],
  );
}
