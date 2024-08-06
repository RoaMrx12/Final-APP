import 'package:centro/pages/consultas/escuelas_regional.dart';
import 'package:flutter/material.dart';

class ConsultaRegionalesPage extends StatelessWidget {
  List<String> _getRegionalList() {
    return List.generate(18, (index) {
      final number = index + 1;
      return number < 10 ? '0$number' : '$number';
    });
  }

  @override
  Widget build(BuildContext context) {
    final regionales = _getRegionalList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Consulta Regionales'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.0, // Hacer que los elementos sean cuadrados
          crossAxisSpacing: 10.0, // Espaciado horizontal entre los cuadros
          mainAxisSpacing: 10.0, // Espaciado vertical entre los cuadros
        ),
        itemCount: regionales.length,
        itemBuilder: (context, index) {
          final regionalNumber = regionales[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EscuelasRegionalPage(regionalNumber: regionalNumber),
                ),
              );
            },
            child: Card(
              color: Colors.lightBlueAccent, // Color medio azulado
              child: Center(
                child: Text(
                  'Regional $regionalNumber',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white, // Color del texto
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
