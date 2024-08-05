import 'package:flutter/material.dart';

class TiposVisitas extends StatelessWidget {
  final List<String> tipos = [
    'Visita de inspección',
    'Visita de evaluación',
    'Visita de seguimiento'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tipos de Visitas'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: tipos.length,
          itemBuilder: (context, index) {
            return _buildTipoTile(tipos[index]);
          },
        ),
      ),
    );
  }

  Widget _buildTipoTile(String tipo) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          tipo,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        onTap: () {
          // Aquí puedes manejar la acción cuando se toque el elemento
          print('Seleccionado: $tipo');
        },
      ),
    );
  }
}
