import 'dart:convert';

class Noticia {
  final String title;
  final String image;
  final String description;
  final String content;
  final String link;

  Noticia({
    required this.title,
    required this.image,
    required this.description,
    required this.content,
    required this.link,
  });

  factory Noticia.fromMap(Map<String, dynamic> json) => Noticia(
    title: json["title"] ?? '',
    image: json["image"] ?? '',
    description: json["description"] ?? '',
    content: json["content"] ?? '',
    link: json["link"] ?? '',
  );

  Map<String, dynamic> toMap() => {
    "title": title,
    "image": image,
    "description": description,
    "content": content,
    "link": link,
  };

  String toJson() => json.encode(toMap());

  factory Noticia.fromJson(String source) => Noticia.fromMap(json.decode(source));
}
