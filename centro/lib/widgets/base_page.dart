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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'lib/assets/logos/menuImagen.png',
                      height: 80, // Ajusta el tamaño según sea necesario
                      width: 80, // Ajusta el tamaño según sea necesario
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Menú',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Perfil'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/perfil_tecnico');
            },
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
            title: Text('Registrar visita'),
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
            leading: Icon(Icons.blur_circular_outlined),
            title: Text('Horoscopo'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/horoscopo');
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
            leading: Icon(Icons.info_outline),
            title: Text('About Us'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/about_us');
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
