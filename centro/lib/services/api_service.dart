import 'dart:convert';
import 'package:centro/models/cambiar_clave_request.dart';
import 'package:centro/models/models.dart';
import 'package:centro/sesion.dart';

import '../api/api_keys.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://adamix.net/minerd';
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  static const String _weatherApiKey = Environment.openWeatherApiKey;

  Future<Map<String, dynamic>> getWeather(String city) async {
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
  Future<Map<String, dynamic>> getHoroscopo() async {
    final response = await http.get(Uri.parse('$baseUrl/horoscopo'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener el horóscopo');
    }
  }

  //Services para Api de Minerd

   Future<List<Centro>> getCentros(String regional) async {
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

  Future<List<Noticia>> getNoticias() async {
    final url = Uri.parse('$baseUrl/def/noticias.php');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data as List).map((noticiaJson) => Noticia.fromMap(noticiaJson)).toList();
    } else {
      throw Exception('Error al obtener las noticias');
    }
  }

  Future<List<Video>> getVideos() async {
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
  
  Future<bool> recuperarClave(String cedula, String correo) async {
    final url = Uri.parse('$baseUrl/def/recuperar_clave.php');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'cedula': cedula,
        'correo': correo,
      }),
    );

    final data = json.decode(response.body);

     if (response.statusCode == 200) {
      if (data['exito']) {
        return data['mensaje'];
      } else {
        throw Exception(data['mensaje']);
      }
    } else {
      throw Exception('Error al recuperar la clave');
    }
  }

  Future<String> registrarVisita(Visita visita) async {
    final url = Uri.parse('$_baseUrl/minerd/registrar_visita.php');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: visita.toJson(),
    );

    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      if (data['exito']) {
        return data['mensaje'];
      } else {
        throw Exception(data['mensaje']);
      }
    } else {
      throw Exception('Error al registrar la visita');
    }
  }

  Future<List<Situacion>> getSituaciones(String token) async {
    final url = Uri.parse('$_baseUrl/def/situaciones.php');
    final response = await http.post(url, body: {'token': token});

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['exito']) {
        final List<dynamic> situacionesJson = data['datos'];
        return situacionesJson.map((json) => Situacion.fromMap(json)).toList();
      } else {
        throw Exception(data['mensaje']);
      }
    } else {
      throw Exception('Error al obtener las situaciones');
    }
  }

   Future<DetalleVisita> getDetalleSituacion(SituacionRequest request) async {
      final url = Uri.parse('$_baseUrl/def/situacion.php');
      final response = await http.post(url, body: {
        'token': request.token,
        'situacion_id': request.situacionId.toString(),
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['exito']) {
          return DetalleVisita.fromMap(data['datos']);
        } else {
          throw Exception(data['mensaje']);
        }
      } else {
        throw Exception('Error al obtener la situación');
      }
   }

  Future<String> cambiarClave(CambiarClaveRequest request) async {
    final url = Uri.parse('$_baseUrl/def/cambiar_clave.php');
    final response = await http.post(url, body: {
      'token': request.token,
      'clave_anterior': request.claveAnterior,
      'clave_nueva': request.claveNueva,
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['exito']) {
        return data['mensaje'];
      } else {
        throw Exception(data['mensaje']);
      }
    } else {
      throw Exception('Error al cambiar la clave');
    }
  }

  Future<Centro> getCentroByCodigo(String codigo) async {
    final url = Uri.parse('$baseUrl/minerd/centros.php?regional=*');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['exito']) {
        final centros = (data['datos'] as List)
            .map((centroJson) => Centro.fromMap(centroJson))
            .toList();

        try {
          final centro = centros.firstWhere((centro) => centro.codigo == codigo);
          return centro;
        } catch (e) {
          throw Exception('Centro no encontrado');
        }
      } else {
        throw Exception(data['mensaje']);
      }
    } else {
      throw Exception('Error al obtener los centros');
    }
  }

}
