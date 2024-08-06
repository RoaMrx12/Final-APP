import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapaPage extends StatelessWidget {
  final double latitud;
  final double longitud;

  MapaPage({required this.latitud, required this.longitud});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa de Ubicación'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(latitud, longitud),
          zoom: 15.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(latitud, longitud),
                builder: (ctx) => Container(
                  child: Icon(Icons.location_on, color: Colors.red, size: 40),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
