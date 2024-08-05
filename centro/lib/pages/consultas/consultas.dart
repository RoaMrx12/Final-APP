import 'package:centro/widgets/base_page.dart';
import 'package:flutter/material.dart';

class ConsultasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Consultas',
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Añade padding alrededor de los botones
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0), // Añade padding entre los botones y los bordes
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/consulta_regionales');
                  },
                  child: Container(
                    color: Colors.blueAccent,
                    child: Center(
                      child: Text(
                        'Consulta Regionales',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0), // Añade padding entre los botones y los bordes
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/consulta_escuela');
                  },
                  child: Container(
                    color: Colors.green,
                    child: Center(
                      child: Text(
                        'Buscar Escuela',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
