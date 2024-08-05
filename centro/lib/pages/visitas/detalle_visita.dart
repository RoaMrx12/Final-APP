import 'package:flutter/material.dart';
import '../../models/visita.dart';

class DetalleVista extends StatelessWidget {
  final Visita visita;

  const DetalleVista({required this.visita, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de Visita'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard('Cédula Director', visita.cedulaDirector),
            _buildInfoCard('Código Centro', visita.codigoCentro),
            _buildInfoCard('Motivo', visita.motivo),
            _buildInfoCard('Comentario', visita.comentario),
            _buildInfoCard('Fecha', visita.fecha),
            _buildInfoCard('Hora', visita.hora),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String content) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(content),
      ),
    );
  }
}
