import 'package:flutter/material.dart';
import '../models/incidencia.dart';

class IncidenciaCard extends StatelessWidget {
  final Incidencia incidencia;
  final VoidCallback onTap;

  const IncidenciaCard({
    Key? key,
    required this.incidencia,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        title: Text(
          incidencia.titulo,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Centro Educativo: ${incidencia.centroEducativo}\n'
          'Fecha: ${incidencia.fecha}',
        ),
        onTap: onTap,
      ),
    );
  }
}
