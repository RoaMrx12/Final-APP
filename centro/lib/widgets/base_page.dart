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
            leading: Icon(Icons.visibility_rounded),
            title: Text('Visitas registradas'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/visitas_registradas');
            },
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Buscar Escuela'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/consultas');
            },
          ),
          ListTile(
            leading: Icon(Icons.cloud),
            title: Text('Clima'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/clima');
            },
          ),
          ListTile(
            leading: Icon(Icons.newspaper),
            title: Text('Noticias'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/noticias');
            },
          ),
          ListTile(
            leading: Icon(Icons.video_collection),
            title: Text('Videos'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/videos');
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
