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
          childAspectRatio: 2.0,
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
              child: Center(
                child: Text('Regional $regionalNumber'),
              ),
            ),
          );
        },
      ),
    );
  }
}
