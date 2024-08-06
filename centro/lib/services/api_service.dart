import 'dart:convert';
import 'package:centro/models/requests/cambiar_clave_request.dart';
import 'package:centro/models/models.dart';
import 'package:centro/models/requests/recuperar_clave_request.dart';
import 'package:centro/sesion.dart';
import '../api/api_keys.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://adamix.net/minerd';

  static const String weaterBaseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  static const String _weatherApiKey = Environment.openWeatherApiKey;

  static const String horoscopoUrl = 'https://horoscope-astrology.p.rapidapi.com/horoscope';
  static const String _horoscopoApiKey = Environment.horoscopoApiKey;
  final String _apiHost = 'horoscope-astrology.p.rapidapi.com';

  Future<Map<String, dynamic>> getWeather(double latitude, double longitude) async {
    final url = Uri.parse('$weaterBaseUrl?lat=$latitude&lon=$longitude&appid=$_weatherApiKey&units=metric&lang=es');

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
  Future<Map<String, dynamic>> getHoroscopo(String signo) async {

    print(signo);
    final response = await http.get(
      Uri.parse('$horoscopoUrl?day=today&sunsign=$signo'),
      headers: {
        'x-rapidapi-key': _horoscopoApiKey,
        'x-rapidapi-host': _apiHost,
      },
    );

    print(response.body);
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
      final videosData = data['datos'] as List;
      return videosData.map((videoJson) => Video.fromMap(videoJson)).toList();
    } else {
      throw Exception('Error al obtener los videos');
    }
  }

  Future<Map<String, dynamic>> registrarTecnico(Tecnico tecnico) async {
    final baseUrl = Uri.parse('https://adamix.net/minerd/def/registro.php');
    final url = baseUrl.replace(queryParameters: {
      'cedula': tecnico.cedula,
      'nombre': tecnico.nombre,
      'apellido': tecnico.apellido,
      'clave': tecnico.clave,
      'correo': tecnico.correo,
      'telefono': tecnico.telefono,
      'fecha_nacimiento': tecnico.fechaNacimiento,
    });

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {
        'exito': data['exito'],
        'mensaje': data['mensaje'],
      };
    } else {
      final errorData = json.decode(response.body);
      throw Exception(errorData['mensaje']);
    }
  }

  Future<void> iniciarSesion(String cedula, String clave) async {
  final bUrl = Uri.parse('$baseUrl/def/iniciar_sesion.php');

  final url = bUrl.replace(queryParameters: {
    'cedula': cedula,
    'clave': clave,
  });

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
  );

  final data = json.decode(response.body);

  if (data['exito']) {
    final tecnicoData = data['datos'];

    SesionActual.token = tecnicoData['token'] ?? '';
    SesionActual.id = tecnicoData['id'] ?? '';
    SesionActual.cedula = cedula;
    SesionActual.nombre = tecnicoData['nombre'] ?? '';
    SesionActual.apellido = tecnicoData['apellido'] ?? '';
    SesionActual.clave = clave;
    SesionActual.correo = tecnicoData['correo'] ?? '';
    SesionActual.telefono = tecnicoData['telefono'] ?? '';
    SesionActual.fechaNacimiento = tecnicoData['fecha_nacimiento'] ?? '';
  } else {
    throw Exception(data['mensaje']);
  }
}

  
  Future<bool> recuperarClave(RecuperarClaveRequest request, String text) async {
    final bUrl = Uri.parse('$baseUrl/def/recuperar_clave.php');

    final url = bUrl.replace(queryParameters: {
    'cedula': request.cedula,
    'correo': request.correo,
    });

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
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
    final bUrl = Uri.parse('$baseUrl/minerd/registrar_visita.php');

    final url = bUrl.replace(queryParameters: {
    'cedula_director': visita.cedulaDirector,
    'codigo_centro': visita.codigoCentro,
    'motivo': visita.motivo,
    'foto_evidencia': visita.fotoPath,
    'comentario': visita.comentario,
    'nota_voz': visita.audioPath,
    'latitud': visita.latitud,
    'longitud': visita.longitud,
    'fecha': visita.fecha,
    'hora': visita.hora,
    'token': SesionActual.token,
    });

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
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
    final bUrl = Uri.parse('$baseUrl/def/situaciones.php');

    final url = bUrl.replace(queryParameters: {
      'token': token
    });

    final response = await http.post(url);

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
    final bUrl = Uri.parse('$baseUrl/def/situacion.php');

    final url = bUrl.replace(queryParameters: {
      'token': request.token,
      'situacion_id': request.situacionId.toString(),
    });

    final response = await http.post(url);

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
    final bUrl = Uri.parse('$baseUrl/def/cambiar_clave.php');

    final url = bUrl.replace(queryParameters: {
      'token': request.token,
      'clave_anterior': request.claveAnterior,
      'clave_nueva': request.claveNueva,
    });

    final response = await http.post(url);

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
