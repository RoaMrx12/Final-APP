import 'package:flutter/material.dart';
import 'package:centro/widgets/visita_card.dart';
import '../models/visita.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  final List<Visita> _visitas = [
    // Aquí puedes agregar algunas visitas de ejemplo
    Visita(
      cedulaDirector: '123456789',
      codigoCentro: 'C001',
      motivo: 'Revisión general',
      fotoEvidenciaPath: '',
      comentario: 'Comentario sobre la visita 1',
      notaVozPath: '',
      latitud: 18.4655,
      longitud: -69.9204,
      fecha: '2024-07-30',
      hora: '10:00',
    ),
    // Agrega más visitas según sea necesario
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Aquí puedes agregar la funcionalidad de búsqueda
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Incidencias',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
         
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Visitas',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ..._visitas.map((visita) => VisitaCard(
            visita: visita,
            onTap: () {
              // Maneja la acción al hacer clic en una visita
            },
          )).toList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Agregar una nueva incidencia o visita
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
