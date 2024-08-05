import 'package:centro/models/centro.dart';
import 'package:centro/pages/visitas/registro_visita.dart';
import 'package:centro/services/api_service.dart';
import 'package:flutter/material.dart';

class EscuelasRegionalPage extends StatefulWidget {
  final String regionalNumber;

  EscuelasRegionalPage({required this.regionalNumber});

  @override
  _EscuelasRegionalPageState createState() => _EscuelasRegionalPageState();
}

class _EscuelasRegionalPageState extends State<EscuelasRegionalPage> {
  late Future<List<Centro>> _futureCentros;

  @override
  void initState() {
    super.initState();
    _futureCentros = ApiService().getCentros(widget.regionalNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Centros Regional ${widget.regionalNumber}'),
      ),
      body: FutureBuilder<List<Centro>>(
        future: _futureCentros,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay centros disponibles'));
          } else {
            // Ordenar los centros alfabéticamente por nombre
            final centrosOrdenados = snapshot.data!..sort((a, b) => a.nombre.compareTo(b.nombre));
            
            return ListView.builder(
              itemCount: centrosOrdenados.length,
              itemBuilder: (context, index) {
                final centro = centrosOrdenados[index];
                return Card(
                  elevation: 4.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  color: Colors.lightBlue[100],
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16.0),
                    title: Text(
                      centro.nombre,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(centro.codigo),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegistroVisita(codigoCentro: centro.codigo),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
