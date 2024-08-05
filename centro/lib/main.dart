import 'package:centro/pages/home.dart';
import 'package:centro/pages/login/recuperar_clave_page.dart';
import 'package:centro/pages/login/registro_page.dart';
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
        '/home': (context) => HomePage(),
        '/registro': (context) => RegistroPage(),
        '/recuperar_clave': (context) => RecuperarClavePage(),
      },
    );
  }
}
