import 'package:flutter/material.dart';
import 'package:centro/widgets/base_page.dart';
import 'package:centro/models/noticia.dart';

class NoticiaDetailPage extends StatelessWidget {
  final Noticia noticia;

  NoticiaDetailPage({required this.noticia});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: noticia.title,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen con icono de repuesto en caso de error
            Image.network(
              noticia.image,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.picture_in_picture, size: 100);
              },
              width: double.infinity, // Ajusta la imagen al ancho del contenedor
              fit: BoxFit.cover, // Ajusta la imagen al contenedor
            ),
            SizedBox(height: 16),
            Text(
              noticia.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              noticia.content,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Lanza el enlace en el navegador
                // launch(noticia.link); // Necesita el paquete url_launcher
              },
              child: Text('Leer más'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Volver a Noticias'),
            ),
          ],
        ),
      ),
    );
  }
}
