import 'package:centro/models/requests/cambiar_clave_request.dart';
import 'package:centro/sesion.dart';
import 'package:flutter/material.dart';
import 'package:centro/services/api_service.dart';

class CambiarClavePage extends StatefulWidget {
  @override
  _CambiarClavePageState createState() => _CambiarClavePageState();
}

class _CambiarClavePageState extends State<CambiarClavePage> {
  final ApiService _apiService = ApiService();
  final TextEditingController _claveAnteriorController = TextEditingController();
  final TextEditingController _claveNuevaController = TextEditingController();
  bool _isLoading = false;
  String _mensaje = '';

  void _reiniciarClave() async {
    setState(() {
      _isLoading = true;
    });

    final request = CambiarClaveRequest(
      token: SesionActual.token,
      claveAnterior: _claveAnteriorController.text,
      claveNueva: _claveNuevaController.text,
    );

    try {
      final mensaje = await _apiService.cambiarClave(request);
      setState(() {
        _mensaje = mensaje;
      });
    } catch (e) {
      setState(() {
        _mensaje = 'Error al reiniciar la clave';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reiniciar Clave'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _claveAnteriorController,
              decoration: InputDecoration(labelText: 'Clave Anterior'),
              obscureText: true,
            ),
            TextField(
              controller: _claveNuevaController,
              decoration: InputDecoration(labelText: 'Clave Nueva'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _reiniciarClave,
              child: _isLoading
                  ? CircularProgressIndicator()
                  : Text('Reiniciar Clave'),
            ),
            SizedBox(height: 20),
            Text(
              _mensaje,
              style: TextStyle(color: Color.fromARGB(255, 62, 99, 58)),
            ),
          ],
        ),
      ),
    );
  }
}
