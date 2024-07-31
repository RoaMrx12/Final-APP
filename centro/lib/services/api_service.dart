import 'dart:convert';
import '../api/api_keys.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://api.example.com';
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  static const String _apiKey = Environment.openWeatherApiKey;

  Future<List<dynamic>> fetchNoticias() async {
    final response = await http.get(Uri.parse('https://remolacha.net/wp-json/wp/v2/posts?search=minerd'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener noticias');
    }
  }

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final url = Uri.parse('$_baseUrl?q=$city&appid=$_apiKey&units=metric&lang=es');

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
}
