import 'package:centro/models/detalleVisita.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:io';

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Cédula del Director: ${detalleVisita.cedulaDirector}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('Código del Centro: ${detalleVisita.codigoCentro}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('Motivo: ${detalleVisita.motivo}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('Comentario: ${detalleVisita.comentario}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('Latitud: ${detalleVisita.latitud}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('Longitud: ${detalleVisita.longitud}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('Fecha: ${detalleVisita.fecha}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('Hora: ${detalleVisita.hora}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 16),
              if (detalleVisita.fotoEvidenciaPath != null && detalleVisita.fotoEvidenciaPath!.isNotEmpty)
                Image.file(File(detalleVisita.fotoEvidenciaPath!), height: 200),
              SizedBox(height: 16),
              if (detalleVisita.notaVozPath != null && detalleVisita.notaVozPath!.isNotEmpty)
                ElevatedButton(
                  onPressed: () async {
                    await audioPlayer.play(DeviceFileSource(detalleVisita.notaVozPath!));
                  },
                  child: Text('Reproducir Nota de Voz'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
