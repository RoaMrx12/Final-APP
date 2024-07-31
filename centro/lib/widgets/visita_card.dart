import 'package:flutter/material.dart';
import '../models/visita.dart';

class VisitaCard extends StatelessWidget {
  final Visita visita;
  final VoidCallback onTap;

  const VisitaCard({
    Key? key,
    required this.visita,
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
          'Código: ${visita.codigoCentro}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Motivo: ${visita.motivo}\n'
          'Fecha: ${visita.fecha}\n'
          'Hora: ${visita.hora}',
        ),
        onTap: onTap,
      ),
    );
  }
}
