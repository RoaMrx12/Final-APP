import 'package:centro/models/visitas/detalleVisita.dart';
import 'package:centro/pages/visitas/mapa_visita.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class DetalleVisitaPage extends StatelessWidget {
  final DetalleVisita detalleVisita;

  DetalleVisitaPage({required this.detalleVisita});

  @override
  Widget build(BuildContext context) {
    final audioPlayer = AudioPlayer();

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de Visita'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (detalleVisita.fotoEvidenciaPath != null && detalleVisita.fotoEvidenciaPath!.isNotEmpty)
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Container(
                        width: constraints.maxWidth,
                        child: Image.file(
                          File(detalleVisita.fotoEvidenciaPath!),
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                            return Center(
                              child: Icon(Icons.picture_in_picture, size: 100, color: Colors.grey),
                            );
                          },
                        ),
                      );
                    },
                  ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Cédula del Director: ${detalleVisita.cedulaDirector}', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 8),
                      Text('Código del Centro: ${detalleVisita.codigoCentro}', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Text('Motivo: ${detalleVisita.motivo}', style: TextStyle(fontSize: 18)),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Text('Comentario: ${detalleVisita.comentario}', style: TextStyle(fontSize: 18)),
                      ),
                      SizedBox(height: 8),
                      Text('Latitud: ${detalleVisita.latitud}', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 8),
                      Text('Longitud: ${detalleVisita.longitud}', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 8),
                      Text('Fecha: ${detalleVisita.fecha}', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 8),
                      Text('Hora: ${detalleVisita.hora}', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 16),
                      if (detalleVisita.notaVozPath != null && detalleVisita.notaVozPath!.isNotEmpty)
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              final file = File(detalleVisita.notaVozPath!);
                              if (await file.exists()) {
                                // Solicitar permisos antes de reproducir
                                await Permission.storage.request();
                                await audioPlayer.play(DeviceFileSource(detalleVisita.notaVozPath!));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('El archivo de audio no se encuentra.')),
                                );
                              }
                            },
                            child: Text('Reproducir Nota de Voz'),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MapaPage(
                latitud: detalleVisita.latitud,
                longitud: detalleVisita.longitud,
              ),
            ),
          );
        },
        child: Icon(Icons.map),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
