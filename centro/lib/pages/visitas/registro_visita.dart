import 'package:flutter/material.dart';
import '../../models/usuario.dart';
import '../../services/auth_service.dart';

class RegistroVista extends StatefulWidget {
  @override
  _RegistroVistaState createState() => _RegistroVistaState();
}

class _RegistroVistaState extends State<RegistroVista> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  String _nombre = '';
  String _apellido = '';
  String _matricula = '';
  String _password = '';

  Future<void> _register() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      Usuario usuario = Usuario(
        nombre: _nombre,
        apellido: _apellido,
        matricula: _matricula,
        password: _password,
      );
      await _authService.registerUser(usuario);
      // Optional: Navigate to a different screen or show a success message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Usuario'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTextField('Nombre', (value) => _nombre = value ?? ''),
                _buildTextField('Apellido', (value) => _apellido = value ?? ''),
                _buildTextField('Matrícula', (value) => _matricula = value ?? ''),
                _buildTextField(
                  'Contraseña',
                  (value) => _password = value ?? '',
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Registrar',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label, 
    void Function(String?) onSaved, {
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        obscureText: obscureText,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor ingrese su $label';
          }
          return null;
        },
        onSaved: onSaved,
      ),
    );
  }
}

