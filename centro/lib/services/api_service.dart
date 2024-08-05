import 'dart:convert';
import 'package:centro/models/centro.dart';
import 'package:centro/models/noticia.dart';
import 'package:centro/models/tecnico.dart';
import 'package:centro/models/video.dart';
import 'package:centro/sesion.dart';

import '../api/api_keys.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://adamix.net/minerd';
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  static const String _weatherApiKey = Environment.openWeatherApiKey;

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final url = Uri.parse('$_baseUrl?q=$city&appid=$_weatherApiKey&units=metric&lang=es');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {
        'description': data['weather'][0]['description'],
        'temperature': data['main']['temp'],
      };
    } else {
      throw Exception('No se pudo obtener el clima');
    }
  }

  //TO-DO
  Future<Map<String, dynamic>> fetchHoroscopo() async {
    final response = await http.get(Uri.parse('$baseUrl/horoscopo'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener el horóscopo');
    }
  }

  //Services para Api de Minerd

   Future<List<Centro>> fetchCentros(String regional) async {
    final url = Uri.parse('$baseUrl/minerd/centros.php?regional=$regional');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['exito']) {
        return (data['datos'] as List)
            .map((centroJson) => Centro.fromMap(centroJson))
            .toList();
      } else {
        throw Exception(data['mensaje']);
      }
    } else {
      throw Exception('Error al obtener los centros');
    }
  }

  Future<List<Noticia>> fetchNoticias() async {
    final url = Uri.parse('$baseUrl/def/noticias.php');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data as List).map((noticiaJson) => Noticia.fromMap(noticiaJson)).toList();
    } else {
      throw Exception('Error al obtener las noticias');
    }
  }

  Future<List<Video>> fetchVideos() async {
    final url = Uri.parse('$baseUrl/def/videos.php');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data as List).map((videoJson) => Video.fromMap(videoJson)).toList();
    } else {
      throw Exception('Error al obtener los videos');
    }
  }

  Future<bool> registrarTecnico(Tecnico tecnico) async {
    final url = Uri.parse('$baseUrl/def/registro.php');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: tecnico.toJson(),
    );

    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      return data['exito'];
    } else {
      throw Exception(data['mensaje']);
    }
  }

   Future<void> iniciarSesion(String cedula, String clave) async {
    final url = Uri.parse('$baseUrl/def/iniciar_sesion.php');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'cedula': cedula,
        'clave': clave,
      }),
    );

    final data = json.decode(response.body);

    if (data['exito']) {
      final tecnicoData = data['datos'][0];

      SesionActual.token = data['token'];
      SesionActual.id = tecnicoData['id'];
      SesionActual.cedula = tecnicoData['cedula'];
      SesionActual.nombre = tecnicoData['nombre'];
      SesionActual.apellido = tecnicoData['apellido'];
      SesionActual.clave = tecnicoData['clave'];
      SesionActual.correo = tecnicoData['correo'];
      SesionActual.telefono = tecnicoData['telefono'];
      SesionActual.fechaNacimiento = tecnicoData['fecha_nacimiento'];
    } else {
      throw Exception(data['mensaje']);
    }
  }
  
}
