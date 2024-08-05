import 'package:centro/sesion.dart';
import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  final Widget body;
  final String title;

  BasePage({required this.body, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: _buildDrawer(context),
      body: body,
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueAccent,
            ),
            child: Text(
              'Menú',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Perfil'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/perfil');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configuraciones'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/configuraciones');
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Cerrar Sesión'),
            onTap: () {
              SesionActual.logout();
              Navigator.pushReplacementNamed(context, '/logout');
            },
          ),
        ],
      ),
    );
  }
}
