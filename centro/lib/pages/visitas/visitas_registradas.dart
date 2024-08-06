import 'package:centro/models/visitas/situacion.dart';
import 'package:centro/models/visitas/detalleVisita.dart';
import 'package:centro/models/requests/situacion_request.dart';
import 'package:centro/pages/visitas/detalle_visita.dart';
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
  late Future<List<Situacion>> futureVisitas;

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
        child: FutureBuilder<List<Situacion>>(
          future: futureVisitas,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No hay visitas registradas.'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final visita = snapshot.data![index];
                  return VisitaCard(
                    codigoCentro: visita.codigoCentro,
                    motivo: visita.motivo,
                    fecha: visita.fecha,
                    hora: visita.hora,
                    onTap: () async {
                    try {
                      final detalleVisita = await ApiService().getDetalleSituacion(
                        SituacionRequest(
                          token: SesionActual.token,
                          situacionId: visita.id!,
                        ),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetalleVisitaPage(detalleVisita: detalleVisita),
                        ),
                      );
                    } catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error al obtener detalles: $error')),
                      );
                    }
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
