import 'package:centro/pages/visitas/detalle_visita.dart';
import 'package:flutter/material.dart';
import '../../models/visita.dart';
import '../../models/visita.dart';
import '../../services/db_service.dart';

class VisitasRegistradas extends StatefulWidget {
  @override
  _VisitasRegistradasState createState() => _VisitasRegistradasState();
}

class _VisitasRegistradasState extends State<VisitasRegistradas> {
  final DatabaseService _dbService = DatabaseService();

  late Future<List<Visita>> _visitas;

  @override
  void initState() {
    super.initState();
    _visitas = _dbService.fetchVisitas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visitas Registradas'),
      ),
      body: FutureBuilder<List<Visita>>(
        future: _visitas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay visitas registradas'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Visita visita = snapshot.data![index];
                return ListTile(
                  title: Text(visita.codigoCentro),
                  subtitle: Text(visita.motivo),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalleVista(visita: visita),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
