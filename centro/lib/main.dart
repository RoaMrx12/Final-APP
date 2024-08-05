import 'package:centro/pages/consultas/consulta_escuela.dart';
import 'package:centro/pages/consultas/consulta_regionales.dart';
import 'package:centro/pages/consultas/consultas.dart';
import 'package:centro/pages/home.dart';
import 'package:centro/pages/login/recuperar_clave_page.dart';
import 'package:centro/pages/login/registro_page.dart';
import 'package:centro/pages/visitas/visitas_registradas.dart';
import 'package:flutter/material.dart';
import 'pages/login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicación MINERD',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/logout': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/registro': (context) => RegistroPage(),
        '/recuperar_clave': (context) => RecuperarClavePage(),
        '/visitas_registradas' : (context) => VisitasRegistradas(),
        '/consulta_regionales' : (context) => ConsultaRegionalesPage(),
        '/consulta_escuela': (context) => ConsultaEscuelaPage(),
        '/consultas' : (context) => ConsultasPage(),
      },
    );
  }
}
