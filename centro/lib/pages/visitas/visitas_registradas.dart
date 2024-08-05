import 'package:centro/services/api_service.dart';
import 'package:centro/sesion.dart';
import 'package:centro/widgets/base_page.dart';
import 'package:centro/widgets/visita_card.dart';
import 'package:flutter/material.dart';

class VisitasRegistradas extends StatefulWidget {
  @override
  _VisitasRegistradasState createState() => _VisitasRegistradasState();
}

class _VisitasRegistradasState extends State<VisitasRegistradas> {

  late Future<List<dynamic>> futureVisitas;

  @override
  void initState() {
    super.initState();
    futureVisitas = ApiService().getSituaciones(SesionActual.token);
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Visitas Realizadas',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<dynamic>>(
          future: futureVisitas,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: No hay tecnico registrado.'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No hay visitas registradas.'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final visita = snapshot.data![index];
                  return VisitaCard(
                    codigoCentro: visita['codigo_centro'],
                    motivo: visita['motivo'],
                    fecha: visita['fecha'],
                    hora: visita['hora'],
                    onTap: () {
                      // ToDo
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
