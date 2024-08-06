import 'package:flutter/material.dart';

class VisitaCard extends StatelessWidget {
  final String codigoCentro;
  final String motivo;
  final String fecha;
  final String hora;
  final VoidCallback onTap;

  VisitaCard({
    required this.codigoCentro,
    required this.motivo,
    required this.fecha,
    required this.hora,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(codigoCentro),
        subtitle: Text(motivo),
        trailing: Text(fecha),
        onTap: onTap,
      ),
    );
  }
}
