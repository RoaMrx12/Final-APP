import 'package:flutter/material.dart';
import 'package:centro/services/api_service.dart';
import 'package:centro/services/location_service.dart';
import 'package:centro/widgets/base_page.dart';

class ClimaPage extends StatefulWidget {
  @override
  _ClimaPageState createState() => _ClimaPageState();
}

class _ClimaPageState extends State<ClimaPage> {
  bool _isLoading = true;
  String? _weatherDescription;
  double? _temperature;
  String? _errorMessage;
  IconData? _weatherIcon;

  @override
  void initState() {
    super.initState();
    _getLocationAndWeather();
  }

  Future<void> _getLocationAndWeather() async {
    try {
      final location = await LocationService().getCurrentLocation();
      final weatherService = ApiService();
      final weather = await weatherService.getWeather(location['latitude']!, location['longitude']!);

      setState(() {
        _weatherDescription = weather['description'];
        _temperature = weather['temperature'];
        _weatherIcon = _getWeatherIcon(_weatherDescription); // Decide el icono basado en la descripción del clima
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  IconData? _getWeatherIcon(String? description) {
    if (description == null) return null;
    switch (description.toLowerCase()) {
      case 'clear':
        return Icons.wb_sunny;
      case 'cloudy':
        return Icons.cloud;
      case 'rain':
        return Icons.beach_access;
      case 'snow':
        return Icons.ac_unit;
      case 'storm':
        return Icons.storm;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Clima',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: _isLoading
              ? CircularProgressIndicator()
              : _errorMessage != null
                  ? Text(
                      'Error: $_errorMessage',
                      style: TextStyle(fontSize: 18, color: Colors.red),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cloud,
                          size: 100,
                          color: Colors.blueAccent,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Descripción del clima: $_weatherDescription',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Temperatura: $_temperature°C',
                          style: TextStyle(fontSize: 24, color: Colors.blueGrey[700]),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
