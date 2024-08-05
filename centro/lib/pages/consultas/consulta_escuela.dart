import 'package:flutter/material.dart';
import 'package:centro/services/api_service.dart';
import 'package:centro/models/centro.dart';

class ConsultaEscuelaPage extends StatefulWidget {
  @override
  _ConsultaEscuelaPageState createState() => _ConsultaEscuelaPageState();
}

class _ConsultaEscuelaPageState extends State<ConsultaEscuelaPage> {
  final _codigoController = TextEditingController();
  Centro? _centro;
  String? _errorMessage;
  bool _isLoading = false;

  Future<void> _consultarEscuela() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final centro = await ApiService().getCentroByCodigo(_codigoController.text);
      setState(() {
        _centro = centro;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
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
        title: Text('Consulta Escuela'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _codigoController,
              decoration: InputDecoration(
                labelText: 'Código de la Escuela',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _consultarEscuela,
              child: Text('Consultar'),
            ),
            if (_isLoading)
              CircularProgressIndicator(),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            if (_centro != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Card(
                  elevation: 4.0,
                  child: ListTile(
                    title: Text('Nombre: ${_centro!.nombre}'),
                    subtitle: Text(
                      'Código: ${_centro!.codigo}\n'
                      'Dirección: ${_centro!.coordenadas}',
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
