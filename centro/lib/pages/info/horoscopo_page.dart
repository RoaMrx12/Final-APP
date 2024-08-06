import 'package:flutter/material.dart';
import 'package:centro/services/api_service.dart';
import 'package:centro/sesion.dart';
import 'package:centro/widgets/base_page.dart';

class HoroscopoPage extends StatefulWidget {
  @override
  _HoroscopoPageState createState() => _HoroscopoPageState();
}

class _HoroscopoPageState extends State<HoroscopoPage> {
  final ApiService _apiService = ApiService();
  String _signo = '';
  String _horoscopo = '';
  String _color = '';
  int _luckyNumber = 0;
  String _luckyTime = '';
  String _mood = '';
  List<Map<String, dynamic>> _areas = [];
  bool _isLoading = false;

  void _fetchHoroscopo(String date) async {
    setState(() {
      _isLoading = true;
    });

    final signo = getZodiacSign(date);

    try {
      final result = await _apiService.getHoroscopo(signo);

      setState(() {
        _signo = signo;
        _horoscopo = result['horoscope'] ?? 'No disponible';
        _color = result['color'] ?? 'No disponible';
        _luckyNumber = result['lucky_number'] ?? 0;
        _luckyTime = result['lucky_time'] ?? 'No disponible';
        _mood = result['mood'] ?? 'No disponible';
        _areas = (result['areas'] as List<dynamic>? ?? [])
            .map((area) => area as Map<String, dynamic>)
            .toList();
      });
    } catch (e) {
      setState(() {
        _horoscopo = 'Error al obtener el horóscopo';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchHoroscopo(SesionActual.fechaNacimiento);
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Horóscopo del Día',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSection(
                      title: 'Signo Zodiacal',
                      content: _signo,
                    ),
                    _buildSection(
                      title: 'Horóscopo',
                      content: _horoscopo,
                    ),
                    _buildSection(
                      title: 'Color',
                      content: _color,
                    ),
                    _buildSection(
                      title: 'Número de la suerte',
                      content: '$_luckyNumber',
                    ),
                    _buildSection(
                      title: 'Hora de la suerte',
                      content: _luckyTime,
                    ),
                    _buildSection(
                      title: 'Estado de ánimo',
                      content: _mood,
                    ),
                    SizedBox(height: 20),
                    ..._areas.map((area) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                area['title'] ?? 'Sin título',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5),
                              Text(
                                area['desc'] ?? 'Sin descripción',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  String getZodiacSign(String dateString) {
    try {
      final DateTime date = DateTime.parse(dateString);
      final int day = date.day;
      final int month = date.month;

      if ((month == 1 && day >= 20) || (month == 2 && day <= 18)) return 'aquarius';
      if ((month == 2 && day >= 19) || (month == 3 && day <= 20)) return 'pisces';
      if ((month == 3 && day >= 21) || (month == 4 && day <= 19)) return 'aries';
      if ((month == 4 && day >= 20) || (month == 5 && day <= 20)) return 'taurus';
      if ((month == 5 && day >= 21) || (month == 6 && day <= 20)) return 'gemini';
      if ((month == 6 && day >= 21) || (month == 7 && day <= 22)) return 'cancer';
      if ((month == 7 && day >= 23) || (month == 8 && day <= 22)) return 'leo';
      if ((month == 8 && day >= 23) || (month == 9 && day <= 22)) return 'virgo';
      if ((month == 9 && day >= 23) || (month == 10 && day <= 22)) return 'libra';
      if ((month == 10 && day >= 23) || (month == 11 && day <= 21)) return 'scorpio';
      if ((month == 11 && day >= 22) || (month == 12 && day <= 21)) return 'sagittarius';
      if ((month == 12 && day >= 22) || (month == 1 && day <= 19)) return 'capricorn';

      return 'unknown';
    } catch (e) {
      return 'invalid';
    }
  }
}
