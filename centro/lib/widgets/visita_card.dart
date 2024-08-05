import 'package:flutter/material.dart';

class VisitaCard extends StatelessWidget {
  final String codigoCentro;
  final String motivo;
  final String fecha;
  final String hora;
  final VoidCallback onTap;

  const VisitaCard({
    Key? key,
    required this.codigoCentro,
    required this.motivo,
    required this.fecha,
    required this.hora,
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
          'Código: $codigoCentro',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Motivo: $motivo\n'
          'Fecha: $fecha\n'
          'Hora: $hora',
        ),
        onTap: onTap,
      ),
    );
  }
}
