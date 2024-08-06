import 'package:flutter/material.dart';
import 'package:centro/sesion.dart';
import 'package:centro/services/db_service.dart';
import 'package:centro/services/api_service.dart';
import 'package:centro/widgets/base_page.dart';
import 'cambiar_clave_page.dart';

class SesionPage extends StatelessWidget {
  final ApiService _apiService = ApiService();
  final DatabaseService _dbService = DatabaseService();

  Future<void> _borrarInformacion(BuildContext context) async {
    final TextEditingController _claveController = TextEditingController();
    
    bool isCorrectKey = false;

    await showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Verificar Clave'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Ingrese la clave actual:'),
              TextField(
                controller: _claveController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Clave actual',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                if (_claveController.text == SesionActual.clave) {
                  isCorrectKey = true;
                  Navigator.of(context).pop(); // Close the dialog
                } else {
                  Navigator.of(context).pop(); // Close the dialog
                }
              },
              child: Text('Confirmar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );

    if (isCorrectKey) {
      await _dbService.deleteAll();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Información borrada con éxito'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Clave incorrecta'),
      ));
    }
  }

  void _reiniciarClave(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CambiarClavePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Información de la Sesión',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(
              Icons.account_circle, 
              size: 88.0,
              color: Colors.blue, 
            ),
            SizedBox(height: 20),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ID: ${SesionActual.id}'),
                    Text('Cédula: ${SesionActual.cedula}'),
                    Text('Nombre: ${SesionActual.nombre}'),
                    Text('Apellido: ${SesionActual.apellido}'),
                    Text('Correo: ${SesionActual.correo}'),
                    Text('Teléfono: ${SesionActual.telefono}'),
                    Text('Fecha de Nacimiento: ${SesionActual.fechaNacimiento}'),
                    Text('Token: ${SesionActual.token}'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _borrarInformacion(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.all(16.0), // Ensure the button is square
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                textStyle: TextStyle(fontSize: 16, color: Colors.white),
              ),
              child: Text('Borrar Información'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _reiniciarClave(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.all(16.0), // Ensure the button is square
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                textStyle: TextStyle(fontSize: 16, color: Colors.white),
              ),
              child: Text('Reiniciar Clave'),
            ),
          ],
        ),
      ),
    );
  }
}
